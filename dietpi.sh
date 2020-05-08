#!/bin/bash

sed -i 's/AUTO_SETUP_LOCALE=.*/AUTO_SETUP_LOCALE=en_US.UTF-8/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_KEYBOARD_LAYOUT=.*/AUTO_SETUP_KEYBOARD_LAYOUT=us/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_TIMEZONE=.*/AUTO_SETUP_TIMEZONE=America\/Phoenix/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_NET_HOSTNAME=.*/AUTO_SETUP_NET_HOSTNAME=Nautilus/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_AUTOMATED=.*/AUTO_SETUP_AUTOMATED=1/' boot/dietpi.txt
sed -i 's/AUTO_SETUP_GLOBAL_PASSWORD=.*/AUTO_SETUP_GLOBAL_PASSWORD=N@utilus/' boot/dietpi.txt
sed -i 's/SURVEY_OPTED_IN=.*/SURVEY_OPTED_IN=1/' boot/dietpi.txt
sed -i 's/CONFIG_BOOT_WAIT_FOR_NETWORK=.*/CONFIG_BOOT_WAIT_FOR_NETWORK=2/' boot/dietpi.txt
sed -i 's/CONFIG_AUTO_DIETPI_UPDATES=.*/CONFIG_AUTO_DIETPI_UPDATES=1/' boot/dietpi.txt
sed -i 's/CONFIG_WIFI_COUNTRY_CODE=.*/CONFIG_WIFI_COUNTRY_CODE=US/' boot/dietpi.txt
sed -i 's/CONFIG_SERIAL_CONSOLE_ENABLE=.*/CONFIG_SERIAL_CONSOLE_ENABLE=0/' boot/dietpi.txt
sed -i 's/CONFIG_ENABLE_IPV6=.*/CONFIG_ENABLE_IPV6=0/' boot/dietpi.txt

cat > boot/Automation_Custom_Script.sh <<EOACS
#!/bin/bash
if [[ -f '/var/lib/dietpi/license.txt' ]]; then mv /var/lib/dietpi/license.txt /var/lib/dietpi/license.accepted ; fi
printf "\n# CUSTOM\ntmpfs /dev/shm tmpfs nosuid,nodev 0 0" >> /etc/fstab
sed -i '/^tmpfs\s\/tmp\stmpfs/c\tmpfs \/tmp tmpfs defaults,nr_inodes=300000 0 0' /etc/fstab
sed -i '/^tmpfs\s\/var\/log\stmpfs/c\tmpfs \/var\/log tmpfs mode=0755,nodev,noexec,nosuid 0 0' /etc/fstab

wget https://secure.nic.cz/files/knot-resolver/knot-resolver-release.deb
dpkg -i knot-resolver-release.deb
apt update
apt install -y knot-resolver knot-dnsutils lua-cqueues

curl -s https://block.energized.pro/spark/formats/rpz.txt > /etc/knot-resolver/energized-spark.rpz
curl -s https://block.energized.pro/extensions/porn-lite/formats/rpz.txt > /etc/knot-resolver/energized-plite.rpz

cat > /etc/systemd/system/update-rpz.service <<EOF
[Unit]
Description=Update RPZ files for Knot Resolver

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'curl -s https://block.energized.pro/spark/formats/rpz.txt > /etc/knot-resolver/energized-spark.rpz ; curl -s https://block.energized.pro/extensions/porn-lite/formats/rpz.txt > /etc/knot-resolver/energized-plite.rpz'
EOF

cat > /etc/systemd/system/update-rpz.timer <<EOF
[Unit]
Description=Update RPZ files for Knot Resolver

[Timer]
OnCalendar=daily
Persistent=true
RandomizedDelaySec=300

[Install]
WantedBy=timers.target
EOF

systemctl enable update-rpz.timer
systemctl start update-rpz.timer

cat > /etc/knot-resolver/kresd.conf <<EOF
-- Knot DNS Resolver configuration in Lua
-- verbose(true)

-- Enable modules
modules = {
  'policy',
  'view',
  'hints > iterate',
  'serve_stale < cache',
  'workarounds < iterate',
  'stats',
  'predict',
  'prefill'
}

-- Disable IPv6
net.ipv6 = false
view:addr('::1', policy.all(policy.DENY))

-- Switch to unprivileged user --
user('knot-resolver','knot-resolver')

-- Set the cache size and location
cache.storage = 'lmdb:///var/cache/knot-resolver'
cache.size = 100 * MB

-- Accept all requests from these non-routable subnets
view:addr('224.0.0.0/4', function (req, qry) return policy.PASS end)
view:addr('240.0.0.0/4', function (req, qry) return policy.PASS end)
view:addr('10.0.0.0/8', function (req, qry) return policy.PASS end)
view:addr('127.0.0.1/8', function (req, qry) return policy.PASS end)
view:addr('172.16.0.0/12', function (req, qry) return policy.PASS end)
view:addr('169.254.0.0/16', function (req, qry) return policy.PASS end)
view:addr('192.168.0.1/16', function (req, qry) return policy.PASS end)

-- Drop everything that hasn't matched
view:addr('0.0.0.0/0', function (req, qry) return policy.DROP end)

-- Use the energized.pro RPZ lists
policy.add(policy.rpz(policy.DENY, '/etc/knot-resolver/energized-spark.rpz',true))
policy.add(policy.rpz(policy.DENY, '/etc/knot-resolver/energized-plite.rpz',true))

-- Prevent ESNI
policy.add(policy.pattern(policy.DENY, '\5_esni'))
policy.add(function (req, query)
  if query.stype == kres.type.ANY then
    return policy.DROP
  elseif query.stype == kres.type.ESNI then
    return policy.DROP
  end
end)

-- DNSSEC validation enabled by default in v4+ (no config needed)

-- Hints
hints.root_file = '/usr/share/dns/root.hints'
hints.add_hosts()

-- Daily refresh
prefill.config({
  ['.'] = {
    url = 'https://www.internic.net/domain/root.zone',
    ca_file = '/etc/ssl/certs/ca-certificates.crt',
    interval = 86400  -- seconds
  }
})

-- Forward queries to CleanBrowsing via DNS-over-TLS (DoT)
policy.add(policy.all(policy.TLS_FORWARD({
  {'185.228.168.168', hostname='family-filter-dns.cleanbrowsing.org'},
  {'185.228.169.168', hostname='family-filter-dns.cleanbrowsing.org'}
})))

-- Prefetch learning (20-minute blocks over 24 hours)
predict.config({ window = 20, period = 72 })
EOF

systemctl enable --now kresd@{1..2}.service

echo "nameserver 127.0.0.1" > /etc/resolv.conf
sed -i 's/#prepend\sdomain-name-servers.*/prepend domain-name-servers 127.0.0.1;/' /etc/dhcp/dhclient.conf
> /etc/resolvconf/resolv.conf.d/head
> /etc/resolvconf/resolv.conf.d/tail

mkdir /etc/systemd/system/kresd.socket.d

cat > /etc/systemd/system/kresd.socket.d/override.conf <<EOF
[Socket]
ListenDatagram=\$(hostname -I | cut -d' ' -f1):53
ListenStream=\$(hostname -I | cut -d' ' -f1):53
EOF

mkdir /etc/systemd/system/kresd-tls.socket.d

cat > /etc/systemd/system/kresd-tls.socket.d/override.conf <<EOF
[Socket]
ListenStream=\$(hostname -I | cut -d' ' -f1):853
EOF

systemctl restart system-kresd.slice

DEBIAN_FRONTEND=noninteractive apt install -y iptables iptables-persistent netfilter-persistent

sed -i 's/#net\.ipv4\.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT
iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT
iptables -t nat -A POSTROUTING -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
systemctl start netfilter-persistent.service
systemctl enable netfilter-persistent.service

ip6tables -I FORWARD -i eth0 -j REJECT
ip6tables-save > /etc/iptables/rules.v6
systemctl restart netfilter-persistent.service

apt install -y git golang libpcap-dev libusb-dev libnetfilter-queue-dev

wget $(curl -sL https://github.com/bettercap/bettercap/releases/latest | grep -o 'href.*armhf.*zip' | sed 's/href="/https:\/\/github.com/')
unzip bettercap_linux_armhf_v*.zip && rm bettercap_linux_armhf_v*.zip
sha256sum -c bettercap_linux_armhf_v*.sha256 && rm bettercap_linux_armhf_v*.sha256 && mv bettercap /usr/local/bin

mkdir -p /var/www/html

bettercap -eval "caplets.update; set https.proxy.certificate.locality Nautilus; https.proxy on; set https.server.certificate.locality Nautilus; https.server on; quit"

cp /root/.bettercap-ca.cert.pem /var/www/html/nautilus.crt

EOACS
