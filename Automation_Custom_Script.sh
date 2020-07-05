#!/bin/bash

# accept GPL license
# Note: will be replaced soon by AUTO_SETUP_ACCEPT_LICENSE=1 (see: https://github.com/MichaIng/DietPi/pull/3621 )
if [[ -f '/var/lib/dietpi/license.txt' ]]; then mv /var/lib/dietpi/license.txt /var/lib/dietpi/license.accepted ; fi

# install all prerequisites
DEBIAN_FRONTEND=noninteractive apt install -y git golang dnsutils nftables iptables iptables-persistent netfilter-persistent screen dsniff openssl sslsplit

# keep iptables due to reliance on legacy tools, like ndpi-netfilter, until they support nftables (https://wiki.debian.org/nftables)
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
update-alternatives --set arptables /usr/sbin/arptables-legacy
update-alternatives --set ebtables /usr/sbin/ebtables-legacy

# FLTR scripts
echo '#!/bin/bash' > /etc/rc.local
chmod +x /etc/rc.local
mkdir -p /etc/fltr
echo '#!/bin/bash' > /etc/fltr/cron_twice_daily.sh
chmod +x /etc/fltr/cron_twice_daily.sh
crontab <<EOF
44 6,18 * * * /etc/fltr/cron_twice_daily.sh
EOF

# set up browser SafeSearch
echo "# Safe Search" > /etc/fltr/safesearch

GIP=$(dig +short forcesafesearch.google.com | tail -n 1) || GIP="216.239.38.120"
YIP=$(dig +short restrict.youtube.com | tail -n 1) || YIP="216.239.38.120"
BIP=$(dig +short strict.bing.com | tail -n 1) || BIP="204.79.197.220"

echo "$GIP www.google.com" >> /etc/fltr/safesearch
echo "$GIP www.google.ac" >> /etc/fltr/safesearch
echo "$GIP www.google.ad" >> /etc/fltr/safesearch
echo "$GIP www.google.ae" >> /etc/fltr/safesearch
echo "$GIP www.google.com.af" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ag" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ai" >> /etc/fltr/safesearch
echo "$GIP www.google.al" >> /etc/fltr/safesearch
echo "$GIP www.google.am" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ao" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ar" >> /etc/fltr/safesearch
echo "$GIP www.google.as" >> /etc/fltr/safesearch
echo "$GIP www.google.at" >> /etc/fltr/safesearch
echo "$GIP www.google.com.au" >> /etc/fltr/safesearch
echo "$GIP www.google.az" >> /etc/fltr/safesearch
echo "$GIP www.google.ba" >> /etc/fltr/safesearch
echo "$GIP www.google.com.bd" >> /etc/fltr/safesearch
echo "$GIP www.google.be" >> /etc/fltr/safesearch
echo "$GIP www.google.bf" >> /etc/fltr/safesearch
echo "$GIP www.google.bg" >> /etc/fltr/safesearch
echo "$GIP www.google.com.bh" >> /etc/fltr/safesearch
echo "$GIP www.google.bi" >> /etc/fltr/safesearch
echo "$GIP www.google.bj" >> /etc/fltr/safesearch
echo "$GIP www.google.com.bn" >> /etc/fltr/safesearch
echo "$GIP www.google.com.bo" >> /etc/fltr/safesearch
echo "$GIP www.google.com.br" >> /etc/fltr/safesearch
echo "$GIP www.google.bs" >> /etc/fltr/safesearch
echo "$GIP www.google.bt" >> /etc/fltr/safesearch
echo "$GIP www.google.co.bw" >> /etc/fltr/safesearch
echo "$GIP www.google.by" >> /etc/fltr/safesearch
echo "$GIP www.google.com.bz" >> /etc/fltr/safesearch
echo "$GIP www.google.ca" >> /etc/fltr/safesearch
echo "$GIP www.google.com.kh" >> /etc/fltr/safesearch
echo "$GIP www.google.cc" >> /etc/fltr/safesearch
echo "$GIP www.google.cd" >> /etc/fltr/safesearch
echo "$GIP www.google.cf" >> /etc/fltr/safesearch
echo "$GIP www.google.cat" >> /etc/fltr/safesearch
echo "$GIP www.google.cg" >> /etc/fltr/safesearch
echo "$GIP www.google.ch" >> /etc/fltr/safesearch
echo "$GIP www.google.ci" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ck" >> /etc/fltr/safesearch
echo "$GIP www.google.cl" >> /etc/fltr/safesearch
echo "$GIP www.google.cm" >> /etc/fltr/safesearch
echo "$GIP www.google.cn" >> /etc/fltr/safesearch
echo "$GIP www.google.com.co" >> /etc/fltr/safesearch
echo "$GIP www.google.co.cr" >> /etc/fltr/safesearch
echo "$GIP www.google.com.cu" >> /etc/fltr/safesearch
echo "$GIP www.google.cv" >> /etc/fltr/safesearch
echo "$GIP www.google.com.cy" >> /etc/fltr/safesearch
echo "$GIP www.google.cz" >> /etc/fltr/safesearch
echo "$GIP www.google.de" >> /etc/fltr/safesearch
echo "$GIP www.google.dj" >> /etc/fltr/safesearch
echo "$GIP www.google.dk" >> /etc/fltr/safesearch
echo "$GIP www.google.dm" >> /etc/fltr/safesearch
echo "$GIP www.google.com.do" >> /etc/fltr/safesearch
echo "$GIP www.google.dz" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ec" >> /etc/fltr/safesearch
echo "$GIP www.google.ee" >> /etc/fltr/safesearch
echo "$GIP www.google.com.eg" >> /etc/fltr/safesearch
echo "$GIP www.google.es" >> /etc/fltr/safesearch
echo "$GIP www.google.com.et" >> /etc/fltr/safesearch
echo "$GIP www.google.fi" >> /etc/fltr/safesearch
echo "$GIP www.google.com.fj" >> /etc/fltr/safesearch
echo "$GIP www.google.fm" >> /etc/fltr/safesearch
echo "$GIP www.google.fr" >> /etc/fltr/safesearch
echo "$GIP www.google.ga" >> /etc/fltr/safesearch
echo "$GIP www.google.ge" >> /etc/fltr/safesearch
echo "$GIP www.google.gf" >> /etc/fltr/safesearch
echo "$GIP www.google.gg" >> /etc/fltr/safesearch
echo "$GIP www.google.com.gh" >> /etc/fltr/safesearch
echo "$GIP www.google.com.gi" >> /etc/fltr/safesearch
echo "$GIP www.google.gl" >> /etc/fltr/safesearch
echo "$GIP www.google.gm" >> /etc/fltr/safesearch
echo "$GIP www.google.gp" >> /etc/fltr/safesearch
echo "$GIP www.google.gr" >> /etc/fltr/safesearch
echo "$GIP www.google.com.gt" >> /etc/fltr/safesearch
echo "$GIP www.google.gy" >> /etc/fltr/safesearch
echo "$GIP www.google.com.hk" >> /etc/fltr/safesearch
echo "$GIP www.google.hn" >> /etc/fltr/safesearch
echo "$GIP www.google.hr" >> /etc/fltr/safesearch
echo "$GIP www.google.ht" >> /etc/fltr/safesearch
echo "$GIP www.google.hu" >> /etc/fltr/safesearch
echo "$GIP www.google.co.id" >> /etc/fltr/safesearch
echo "$GIP www.google.iq" >> /etc/fltr/safesearch
echo "$GIP www.google.ie" >> /etc/fltr/safesearch
echo "$GIP www.google.co.il" >> /etc/fltr/safesearch
echo "$GIP www.google.im" >> /etc/fltr/safesearch
echo "$GIP www.google.co.in" >> /etc/fltr/safesearch
echo "$GIP www.google.io" >> /etc/fltr/safesearch
echo "$GIP www.google.is" >> /etc/fltr/safesearch
echo "$GIP www.google.it" >> /etc/fltr/safesearch
echo "$GIP www.google.je" >> /etc/fltr/safesearch
echo "$GIP www.google.com.jm" >> /etc/fltr/safesearch
echo "$GIP www.google.jo" >> /etc/fltr/safesearch
echo "$GIP www.google.co.jp" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ke" >> /etc/fltr/safesearch
echo "$GIP www.google.ki" >> /etc/fltr/safesearch
echo "$GIP www.google.kg" >> /etc/fltr/safesearch
echo "$GIP www.google.co.kr" >> /etc/fltr/safesearch
echo "$GIP www.google.com.kw" >> /etc/fltr/safesearch
echo "$GIP www.google.kz" >> /etc/fltr/safesearch
echo "$GIP www.google.la" >> /etc/fltr/safesearch
echo "$GIP www.google.com.lb" >> /etc/fltr/safesearch
echo "$GIP www.google.com.lc" >> /etc/fltr/safesearch
echo "$GIP www.google.li" >> /etc/fltr/safesearch
echo "$GIP www.google.lk" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ls" >> /etc/fltr/safesearch
echo "$GIP www.google.lt" >> /etc/fltr/safesearch
echo "$GIP www.google.lu" >> /etc/fltr/safesearch
echo "$GIP www.google.lv" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ly" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ma" >> /etc/fltr/safesearch
echo "$GIP www.google.md" >> /etc/fltr/safesearch
echo "$GIP www.google.me" >> /etc/fltr/safesearch
echo "$GIP www.google.mg" >> /etc/fltr/safesearch
echo "$GIP www.google.mk" >> /etc/fltr/safesearch
echo "$GIP www.google.ml" >> /etc/fltr/safesearch
echo "$GIP www.google.com.mm" >> /etc/fltr/safesearch
echo "$GIP www.google.mn" >> /etc/fltr/safesearch
echo "$GIP www.google.ms" >> /etc/fltr/safesearch
echo "$GIP www.google.com.mt" >> /etc/fltr/safesearch
echo "$GIP www.google.mu" >> /etc/fltr/safesearch
echo "$GIP www.google.mv" >> /etc/fltr/safesearch
echo "$GIP www.google.mw" >> /etc/fltr/safesearch
echo "$GIP www.google.com.mx" >> /etc/fltr/safesearch
echo "$GIP www.google.com.my" >> /etc/fltr/safesearch
echo "$GIP www.google.co.mz" >> /etc/fltr/safesearch
echo "$GIP www.google.com.na" >> /etc/fltr/safesearch
echo "$GIP www.google.ne" >> /etc/fltr/safesearch
echo "$GIP www.google.com.nf" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ng" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ni" >> /etc/fltr/safesearch
echo "$GIP www.google.nl" >> /etc/fltr/safesearch
echo "$GIP www.google.no" >> /etc/fltr/safesearch
echo "$GIP www.google.com.np" >> /etc/fltr/safesearch
echo "$GIP www.google.nr" >> /etc/fltr/safesearch
echo "$GIP www.google.nu" >> /etc/fltr/safesearch
echo "$GIP www.google.co.nz" >> /etc/fltr/safesearch
echo "$GIP www.google.com.om" >> /etc/fltr/safesearch
echo "$GIP www.google.com.pk" >> /etc/fltr/safesearch
echo "$GIP www.google.com.pa" >> /etc/fltr/safesearch
echo "$GIP www.google.com.pe" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ph" >> /etc/fltr/safesearch
echo "$GIP www.google.pl" >> /etc/fltr/safesearch
echo "$GIP www.google.com.pg" >> /etc/fltr/safesearch
echo "$GIP www.google.pn" >> /etc/fltr/safesearch
echo "$GIP www.google.com.pr" >> /etc/fltr/safesearch
echo "$GIP www.google.ps" >> /etc/fltr/safesearch
echo "$GIP www.google.pt" >> /etc/fltr/safesearch
echo "$GIP www.google.com.py" >> /etc/fltr/safesearch
echo "$GIP www.google.com.qa" >> /etc/fltr/safesearch
echo "$GIP www.google.ro" >> /etc/fltr/safesearch
echo "$GIP www.google.rs" >> /etc/fltr/safesearch
echo "$GIP www.google.ru" >> /etc/fltr/safesearch
echo "$GIP www.google.rw" >> /etc/fltr/safesearch
echo "$GIP www.google.com.sa" >> /etc/fltr/safesearch
echo "$GIP www.google.com.sb" >> /etc/fltr/safesearch
echo "$GIP www.google.sc" >> /etc/fltr/safesearch
echo "$GIP www.google.se" >> /etc/fltr/safesearch
echo "$GIP www.google.com.sg" >> /etc/fltr/safesearch
echo "$GIP www.google.sh" >> /etc/fltr/safesearch
echo "$GIP www.google.si" >> /etc/fltr/safesearch
echo "$GIP www.google.sk" >> /etc/fltr/safesearch
echo "$GIP www.google.com.sl" >> /etc/fltr/safesearch
echo "$GIP www.google.sn" >> /etc/fltr/safesearch
echo "$GIP www.google.sm" >> /etc/fltr/safesearch
echo "$GIP www.google.so" >> /etc/fltr/safesearch
echo "$GIP www.google.st" >> /etc/fltr/safesearch
echo "$GIP www.google.sr" >> /etc/fltr/safesearch
echo "$GIP www.google.com.sv" >> /etc/fltr/safesearch
echo "$GIP www.google.td" >> /etc/fltr/safesearch
echo "$GIP www.google.tg" >> /etc/fltr/safesearch
echo "$GIP www.google.co.th" >> /etc/fltr/safesearch
echo "$GIP www.google.com.tj" >> /etc/fltr/safesearch
echo "$GIP www.google.tk" >> /etc/fltr/safesearch
echo "$GIP www.google.tl" >> /etc/fltr/safesearch
echo "$GIP www.google.tm" >> /etc/fltr/safesearch
echo "$GIP www.google.to" >> /etc/fltr/safesearch
echo "$GIP www.google.tn" >> /etc/fltr/safesearch
echo "$GIP www.google.com.tr" >> /etc/fltr/safesearch
echo "$GIP www.google.tt" >> /etc/fltr/safesearch
echo "$GIP www.google.com.tw" >> /etc/fltr/safesearch
echo "$GIP www.google.co.tz" >> /etc/fltr/safesearch
echo "$GIP www.google.com.ua" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ug" >> /etc/fltr/safesearch
echo "$GIP www.google.co.uk" >> /etc/fltr/safesearch
echo "$GIP www.google.com" >> /etc/fltr/safesearch
echo "$GIP www.google.com.uy" >> /etc/fltr/safesearch
echo "$GIP www.google.co.uz" >> /etc/fltr/safesearch
echo "$GIP www.google.com.vc" >> /etc/fltr/safesearch
echo "$GIP www.google.co.ve" >> /etc/fltr/safesearch
echo "$GIP www.google.vg" >> /etc/fltr/safesearch
echo "$GIP www.google.co.vi" >> /etc/fltr/safesearch
echo "$GIP www.google.com.vn" >> /etc/fltr/safesearch
echo "$GIP www.google.vu" >> /etc/fltr/safesearch
echo "$GIP www.google.ws" >> /etc/fltr/safesearch
echo "$GIP www.google.co.za" >> /etc/fltr/safesearch
echo "$GIP www.google.co.zm" >> /etc/fltr/safesearch
echo "$GIP www.google.co.zw" >> /etc/fltr/safesearch

echo "$YIP www.youtube.com m.youtube.com youtubei.googleapis.com youtube.googleapis.com www.youtube-nocookie.com" >> /etc/fltr/safesearch

echo "$BIP www.bing.com bing.com" >> /etc/fltr/safesearch

# set up blocklists
echo 'curl -so /tmp/spark https://block.energized.pro/spark/formats/hosts.txt && curl -so /tmp/plite https://block.energized.pro/extensions/porn-lite/formats/hosts && cat /etc/fltr/safesearch /tmp/spark /tmp/plite > /etc/hosts' >> /etc/fltr/cron_twice_daily.sh

# DuckDuckGo SafeSearch is a special case - see: https://www.reddit.com/r/duckduckgo/comments/8qwzyl/feature_request_allow_network_operators_for_force/
echo 'printf "\n\n# DuckDuckGo SafeSearch\n$(dig +short safe.duckduckgo.com | tail -n 1) www.duckduckgo.com duckduckgo.com\n" >> /etc/hosts' >> /etc/fltr/cron_twice_daily.sh

# initialize blocklists
/etc/fltr/cron_twice_daily.sh

# install and configure CoreDNS
mkdir -p /etc/coredns/zones
wget $(curl -sL https://github.com/coredns/coredns/releases/latest | grep -o -m 1 'href.*arm64.*tgz' | sed 's/href="/https:\/\/github.com/') && tar -xf coredns* && rm coredns_* && mv coredns /usr/local/bin

cat > /etc/coredns/Corefile <<EOF
. {
  nsid FLTR
  root /etc/coredns/zones
  any
  acl {
    allow net 224.0.0.0/4 240.0.0.0/4 10.0.0.0/8 127.0.0.0/8 172.16.0.0/12 169.254.0.0/16 192.168.0.0/16
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
PIDFile=/etc/coredns/coredns.pid
LimitNOFILE=8192
User=root
WorkingDirectory=/etc/coredns
ExecStartPre=/sbin/setcap cap_net_bind_service=+ep /usr/local/bin/coredns
ExecStart=/usr/local/bin/coredns -pidfile /etc/coredns/coredns.pid -conf=/etc/coredns/Corefile
ExecReload=/bin/kill -SIGUSR1 $MAINPID
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF

service coredns start && systemctl enable coredns

# force local DNS traffic through CoreDNS
echo "nameserver 127.0.0.1" > /etc/resolv.conf
sed -i 's/#prepend\sdomain-name-servers.*/prepend domain-name-servers 127.0.0.1;/' /etc/dhcp/dhclient.conf
> /etc/resolvconf/resolv.conf.d/head
> /etc/resolvconf/resolv.conf.d/tail

# networking config
sed -i 's/#net\.ipv4\.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# prevent SSH brute forcing
iptables -A INPUT -p tcp -s 224.0.0.0/4 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 240.0.0.0/4 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 10.0.0.0/8 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 127.0.0.0/8 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.0.0/12 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 169.254.0.0/16 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp --dport ssh -j REJECT

# route all external DNS traffic through CoreDNS
iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT
iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT
iptables -t nat -A POSTROUTING -j MASQUERADE

iptables-save > /etc/iptables/rules.v4
systemctl start netfilter-persistent.service && systemctl enable netfilter-persistent.service

# disable IPv6
ip6tables -I FORWARD -i eth0 -j REJECT
ip6tables-save > /etc/iptables/rules.v6

systemctl restart netfilter-persistent.service

# arp spoof (dev)
echo "screen -S fltr_arpspoof -d -m arpspoof -i eth0 -t TESTMACHINEIPADDRESS $(ip r | grep '^default' | cut -d' ' -f3)" >> /etc/rc.local

# arp spoof (prod)
#echo "screen -S fltr_arpspoof -d -m arpspoof -i eth0 $(ip r | grep '^default' | cut -d' ' -f3)" >> /etc/rc.local
