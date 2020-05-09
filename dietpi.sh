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

apt install -y git golang dnsutils
wget $(curl -sL https://github.com/coredns/coredns/releases/latest | grep -o -m 1 'href.*arm64.*tgz' | sed 's/href="/https:\/\/github.com/') && tar -xf coredns* && rm coredns_* && mv coredns /usr/local/bin

mkdir -p /etc/coredns/zones

echo "# Safe Search" > /etc/coredns/safesearch

GIP=$(dig +short forcesafesearch.google.com | tail -n 1)
YIP=$(dig +short restrict.youtube.com | tail -n 1)
DIP=$(dig +short safe.duckduckgo.com | tail -n 1)
BIP=$(dig +short strict.bing.com | tail -n 1)

echo "$GIP www.google.com" >> /etc/coredns/safesearch
echo "$GIP www.google.ac" >> /etc/coredns/safesearch
echo "$GIP www.google.ad" >> /etc/coredns/safesearch
echo "$GIP www.google.ae" >> /etc/coredns/safesearch
echo "$GIP www.google.com.af" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ag" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ai" >> /etc/coredns/safesearch
echo "$GIP www.google.al" >> /etc/coredns/safesearch
echo "$GIP www.google.am" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ao" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ar" >> /etc/coredns/safesearch
echo "$GIP www.google.as" >> /etc/coredns/safesearch
echo "$GIP www.google.at" >> /etc/coredns/safesearch
echo "$GIP www.google.com.au" >> /etc/coredns/safesearch
echo "$GIP www.google.az" >> /etc/coredns/safesearch
echo "$GIP www.google.ba" >> /etc/coredns/safesearch
echo "$GIP www.google.com.bd" >> /etc/coredns/safesearch
echo "$GIP www.google.be" >> /etc/coredns/safesearch
echo "$GIP www.google.bf" >> /etc/coredns/safesearch
echo "$GIP www.google.bg" >> /etc/coredns/safesearch
echo "$GIP www.google.com.bh" >> /etc/coredns/safesearch
echo "$GIP www.google.bi" >> /etc/coredns/safesearch
echo "$GIP www.google.bj" >> /etc/coredns/safesearch
echo "$GIP www.google.com.bn" >> /etc/coredns/safesearch
echo "$GIP www.google.com.bo" >> /etc/coredns/safesearch
echo "$GIP www.google.com.br" >> /etc/coredns/safesearch
echo "$GIP www.google.bs" >> /etc/coredns/safesearch
echo "$GIP www.google.bt" >> /etc/coredns/safesearch
echo "$GIP www.google.co.bw" >> /etc/coredns/safesearch
echo "$GIP www.google.by" >> /etc/coredns/safesearch
echo "$GIP www.google.com.bz" >> /etc/coredns/safesearch
echo "$GIP www.google.ca" >> /etc/coredns/safesearch
echo "$GIP www.google.com.kh" >> /etc/coredns/safesearch
echo "$GIP www.google.cc" >> /etc/coredns/safesearch
echo "$GIP www.google.cd" >> /etc/coredns/safesearch
echo "$GIP www.google.cf" >> /etc/coredns/safesearch
echo "$GIP www.google.cat" >> /etc/coredns/safesearch
echo "$GIP www.google.cg" >> /etc/coredns/safesearch
echo "$GIP www.google.ch" >> /etc/coredns/safesearch
echo "$GIP www.google.ci" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ck" >> /etc/coredns/safesearch
echo "$GIP www.google.cl" >> /etc/coredns/safesearch
echo "$GIP www.google.cm" >> /etc/coredns/safesearch
echo "$GIP www.google.cn" >> /etc/coredns/safesearch
echo "$GIP www.google.com.co" >> /etc/coredns/safesearch
echo "$GIP www.google.co.cr" >> /etc/coredns/safesearch
echo "$GIP www.google.com.cu" >> /etc/coredns/safesearch
echo "$GIP www.google.cv" >> /etc/coredns/safesearch
echo "$GIP www.google.com.cy" >> /etc/coredns/safesearch
echo "$GIP www.google.cz" >> /etc/coredns/safesearch
echo "$GIP www.google.de" >> /etc/coredns/safesearch
echo "$GIP www.google.dj" >> /etc/coredns/safesearch
echo "$GIP www.google.dk" >> /etc/coredns/safesearch
echo "$GIP www.google.dm" >> /etc/coredns/safesearch
echo "$GIP www.google.com.do" >> /etc/coredns/safesearch
echo "$GIP www.google.dz" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ec" >> /etc/coredns/safesearch
echo "$GIP www.google.ee" >> /etc/coredns/safesearch
echo "$GIP www.google.com.eg" >> /etc/coredns/safesearch
echo "$GIP www.google.es" >> /etc/coredns/safesearch
echo "$GIP www.google.com.et" >> /etc/coredns/safesearch
echo "$GIP www.google.fi" >> /etc/coredns/safesearch
echo "$GIP www.google.com.fj" >> /etc/coredns/safesearch
echo "$GIP www.google.fm" >> /etc/coredns/safesearch
echo "$GIP www.google.fr" >> /etc/coredns/safesearch
echo "$GIP www.google.ga" >> /etc/coredns/safesearch
echo "$GIP www.google.ge" >> /etc/coredns/safesearch
echo "$GIP www.google.gf" >> /etc/coredns/safesearch
echo "$GIP www.google.gg" >> /etc/coredns/safesearch
echo "$GIP www.google.com.gh" >> /etc/coredns/safesearch
echo "$GIP www.google.com.gi" >> /etc/coredns/safesearch
echo "$GIP www.google.gl" >> /etc/coredns/safesearch
echo "$GIP www.google.gm" >> /etc/coredns/safesearch
echo "$GIP www.google.gp" >> /etc/coredns/safesearch
echo "$GIP www.google.gr" >> /etc/coredns/safesearch
echo "$GIP www.google.com.gt" >> /etc/coredns/safesearch
echo "$GIP www.google.gy" >> /etc/coredns/safesearch
echo "$GIP www.google.com.hk" >> /etc/coredns/safesearch
echo "$GIP www.google.hn" >> /etc/coredns/safesearch
echo "$GIP www.google.hr" >> /etc/coredns/safesearch
echo "$GIP www.google.ht" >> /etc/coredns/safesearch
echo "$GIP www.google.hu" >> /etc/coredns/safesearch
echo "$GIP www.google.co.id" >> /etc/coredns/safesearch
echo "$GIP www.google.iq" >> /etc/coredns/safesearch
echo "$GIP www.google.ie" >> /etc/coredns/safesearch
echo "$GIP www.google.co.il" >> /etc/coredns/safesearch
echo "$GIP www.google.im" >> /etc/coredns/safesearch
echo "$GIP www.google.co.in" >> /etc/coredns/safesearch
echo "$GIP www.google.io" >> /etc/coredns/safesearch
echo "$GIP www.google.is" >> /etc/coredns/safesearch
echo "$GIP www.google.it" >> /etc/coredns/safesearch
echo "$GIP www.google.je" >> /etc/coredns/safesearch
echo "$GIP www.google.com.jm" >> /etc/coredns/safesearch
echo "$GIP www.google.jo" >> /etc/coredns/safesearch
echo "$GIP www.google.co.jp" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ke" >> /etc/coredns/safesearch
echo "$GIP www.google.ki" >> /etc/coredns/safesearch
echo "$GIP www.google.kg" >> /etc/coredns/safesearch
echo "$GIP www.google.co.kr" >> /etc/coredns/safesearch
echo "$GIP www.google.com.kw" >> /etc/coredns/safesearch
echo "$GIP www.google.kz" >> /etc/coredns/safesearch
echo "$GIP www.google.la" >> /etc/coredns/safesearch
echo "$GIP www.google.com.lb" >> /etc/coredns/safesearch
echo "$GIP www.google.com.lc" >> /etc/coredns/safesearch
echo "$GIP www.google.li" >> /etc/coredns/safesearch
echo "$GIP www.google.lk" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ls" >> /etc/coredns/safesearch
echo "$GIP www.google.lt" >> /etc/coredns/safesearch
echo "$GIP www.google.lu" >> /etc/coredns/safesearch
echo "$GIP www.google.lv" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ly" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ma" >> /etc/coredns/safesearch
echo "$GIP www.google.md" >> /etc/coredns/safesearch
echo "$GIP www.google.me" >> /etc/coredns/safesearch
echo "$GIP www.google.mg" >> /etc/coredns/safesearch
echo "$GIP www.google.mk" >> /etc/coredns/safesearch
echo "$GIP www.google.ml" >> /etc/coredns/safesearch
echo "$GIP www.google.com.mm" >> /etc/coredns/safesearch
echo "$GIP www.google.mn" >> /etc/coredns/safesearch
echo "$GIP www.google.ms" >> /etc/coredns/safesearch
echo "$GIP www.google.com.mt" >> /etc/coredns/safesearch
echo "$GIP www.google.mu" >> /etc/coredns/safesearch
echo "$GIP www.google.mv" >> /etc/coredns/safesearch
echo "$GIP www.google.mw" >> /etc/coredns/safesearch
echo "$GIP www.google.com.mx" >> /etc/coredns/safesearch
echo "$GIP www.google.com.my" >> /etc/coredns/safesearch
echo "$GIP www.google.co.mz" >> /etc/coredns/safesearch
echo "$GIP www.google.com.na" >> /etc/coredns/safesearch
echo "$GIP www.google.ne" >> /etc/coredns/safesearch
echo "$GIP www.google.com.nf" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ng" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ni" >> /etc/coredns/safesearch
echo "$GIP www.google.nl" >> /etc/coredns/safesearch
echo "$GIP www.google.no" >> /etc/coredns/safesearch
echo "$GIP www.google.com.np" >> /etc/coredns/safesearch
echo "$GIP www.google.nr" >> /etc/coredns/safesearch
echo "$GIP www.google.nu" >> /etc/coredns/safesearch
echo "$GIP www.google.co.nz" >> /etc/coredns/safesearch
echo "$GIP www.google.com.om" >> /etc/coredns/safesearch
echo "$GIP www.google.com.pk" >> /etc/coredns/safesearch
echo "$GIP www.google.com.pa" >> /etc/coredns/safesearch
echo "$GIP www.google.com.pe" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ph" >> /etc/coredns/safesearch
echo "$GIP www.google.pl" >> /etc/coredns/safesearch
echo "$GIP www.google.com.pg" >> /etc/coredns/safesearch
echo "$GIP www.google.pn" >> /etc/coredns/safesearch
echo "$GIP www.google.com.pr" >> /etc/coredns/safesearch
echo "$GIP www.google.ps" >> /etc/coredns/safesearch
echo "$GIP www.google.pt" >> /etc/coredns/safesearch
echo "$GIP www.google.com.py" >> /etc/coredns/safesearch
echo "$GIP www.google.com.qa" >> /etc/coredns/safesearch
echo "$GIP www.google.ro" >> /etc/coredns/safesearch
echo "$GIP www.google.rs" >> /etc/coredns/safesearch
echo "$GIP www.google.ru" >> /etc/coredns/safesearch
echo "$GIP www.google.rw" >> /etc/coredns/safesearch
echo "$GIP www.google.com.sa" >> /etc/coredns/safesearch
echo "$GIP www.google.com.sb" >> /etc/coredns/safesearch
echo "$GIP www.google.sc" >> /etc/coredns/safesearch
echo "$GIP www.google.se" >> /etc/coredns/safesearch
echo "$GIP www.google.com.sg" >> /etc/coredns/safesearch
echo "$GIP www.google.sh" >> /etc/coredns/safesearch
echo "$GIP www.google.si" >> /etc/coredns/safesearch
echo "$GIP www.google.sk" >> /etc/coredns/safesearch
echo "$GIP www.google.com.sl" >> /etc/coredns/safesearch
echo "$GIP www.google.sn" >> /etc/coredns/safesearch
echo "$GIP www.google.sm" >> /etc/coredns/safesearch
echo "$GIP www.google.so" >> /etc/coredns/safesearch
echo "$GIP www.google.st" >> /etc/coredns/safesearch
echo "$GIP www.google.sr" >> /etc/coredns/safesearch
echo "$GIP www.google.com.sv" >> /etc/coredns/safesearch
echo "$GIP www.google.td" >> /etc/coredns/safesearch
echo "$GIP www.google.tg" >> /etc/coredns/safesearch
echo "$GIP www.google.co.th" >> /etc/coredns/safesearch
echo "$GIP www.google.com.tj" >> /etc/coredns/safesearch
echo "$GIP www.google.tk" >> /etc/coredns/safesearch
echo "$GIP www.google.tl" >> /etc/coredns/safesearch
echo "$GIP www.google.tm" >> /etc/coredns/safesearch
echo "$GIP www.google.to" >> /etc/coredns/safesearch
echo "$GIP www.google.tn" >> /etc/coredns/safesearch
echo "$GIP www.google.com.tr" >> /etc/coredns/safesearch
echo "$GIP www.google.tt" >> /etc/coredns/safesearch
echo "$GIP www.google.com.tw" >> /etc/coredns/safesearch
echo "$GIP www.google.co.tz" >> /etc/coredns/safesearch
echo "$GIP www.google.com.ua" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ug" >> /etc/coredns/safesearch
echo "$GIP www.google.co.uk" >> /etc/coredns/safesearch
echo "$GIP www.google.com" >> /etc/coredns/safesearch
echo "$GIP www.google.com.uy" >> /etc/coredns/safesearch
echo "$GIP www.google.co.uz" >> /etc/coredns/safesearch
echo "$GIP www.google.com.vc" >> /etc/coredns/safesearch
echo "$GIP www.google.co.ve" >> /etc/coredns/safesearch
echo "$GIP www.google.vg" >> /etc/coredns/safesearch
echo "$GIP www.google.co.vi" >> /etc/coredns/safesearch
echo "$GIP www.google.com.vn" >> /etc/coredns/safesearch
echo "$GIP www.google.vu" >> /etc/coredns/safesearch
echo "$GIP www.google.ws" >> /etc/coredns/safesearch
echo "$GIP www.google.co.za" >> /etc/coredns/safesearch
echo "$GIP www.google.co.zm" >> /etc/coredns/safesearch
echo "$GIP www.google.co.zw" >> /etc/coredns/safesearch

echo "$YIP www.youtube.com m.youtube.com youtubei.googleapis.com youtube.googleapis.com www.youtube-nocookie.com" >> /etc/coredns/safesearch

echo "$DIP www.duckduckgo.com duckduckgo.com" >> /etc/coredns/safesearch

echo "$BIP www.bing.com bing.com" >> /etc/coredns/safesearch

curl -so /tmp/spark https://block.energized.pro/spark/formats/hosts.txt && curl -so /tmp/plite https://block.energized.pro/extensions/porn-lite/formats/hosts && cat /etc/coredns/safesearch /tmp/spark /tmp/plite > /etc/hosts

crontab <<EOF
44 5,14 * * * curl -so /tmp/spark https://block.energized.pro/spark/formats/hosts.txt && curl -so /tmp/plite https://block.energized.pro/extensions/porn-lite/formats/hosts && cat /etc/coredns/safesearch /tmp/spark /tmp/plite > /etc/hosts
EOF

cat > /etc/coredns/Corefile <<EOF
. {
  nsid Nautilus
  root /etc/coredns/zones
  any
  acl {
    allow net 224.0.0.0/4 240.0.0.0/4 10.0.0.0/8 127.0.0.1/8 172.16.0.0/12 169.254.0.0/16 192.168.0.1/16
    block
  }
  bufsize 1232
  hosts {
    fallthrough
  }
  rewrite name prefix _esni. nope.
  forward . tls://185.228.168.168 tls://185.228.169.168 {
    tls_servername family-filter-dns.cleanbrowsing.org
    health_check 5s
  }
  cache 300
  errors
  log
}
EOF

cat > /etc/systemd/system/coredns.service <<EOF
[Unit]
Description=CoreDNS DNS server
Documentation=https://coredns.io
After=network.target
StartLimitInterval=200
StartLimitBurst=3

[Service]
PermissionsStartOnly=true
PIDFile=/root/coredns.pid
LimitNOFILE=8192
User=root
WorkingDirectory=/root
ExecStartPre=/sbin/setcap cap_net_bind_service=+ep /usr/local/bin/coredns
ExecStart=/usr/local/bin/coredns -pidfile /root/coredns.pid -conf=/etc/coredns/Corefile
ExecReload=/bin/kill -SIGUSR1 $MAINPID
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

service coredns start
systemctl enable coredns

echo "nameserver 127.0.0.1" > /etc/resolv.conf
sed -i 's/#prepend\sdomain-name-servers.*/prepend domain-name-servers 127.0.0.1;/' /etc/dhcp/dhclient.conf
> /etc/resolvconf/resolv.conf.d/head
> /etc/resolvconf/resolv.conf.d/tail

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

apt install -y screen dsniff openssl sslsplit 

EOACS
