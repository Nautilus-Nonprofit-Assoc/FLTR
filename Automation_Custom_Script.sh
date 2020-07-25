#!/bin/bash

# install all prerequisites
DEBIAN_FRONTEND=noninteractive apt -t buster-backports install -y -qq git golang-go iptables iptables-persistent netfilter-persistent dnsutils screen build-essential libpcap-dev libusb-1.0-0-dev libnetfilter-queue-dev pkg-config

# run twice daily
mkdir -p /etc/fltr
echo '#!/bin/bash' > /etc/fltr/cron_twice_daily.sh
chmod +x /etc/fltr/cron_twice_daily.sh
crontab <<EOF
44 6,18 * * * /etc/fltr/cron_twice_daily.sh
EOF

# set up browser SafeSearch
GIP=$(dig +short forcesafesearch.google.com | tail -n 1) || GIP="216.239.38.120"
YIP=$(dig +short restrict.youtube.com | tail -n 1) || YIP="216.239.38.120"
BIP=$(dig +short strict.bing.com | tail -n 1) || BIP="204.79.197.220"
echo "# Safe Search" > /etc/fltr/safesearch
cat >> /etc/fltr/safesearch <<EOF
${GIP} www.google.com
${GIP} www.google.ac
${GIP} www.google.ad
${GIP} www.google.ae
${GIP} www.google.com.af
${GIP} www.google.com.ag
${GIP} www.google.com.ai
${GIP} www.google.al
${GIP} www.google.am
${GIP} www.google.co.ao
${GIP} www.google.com.ar
${GIP} www.google.as
${GIP} www.google.at
${GIP} www.google.com.au
${GIP} www.google.az
${GIP} www.google.ba
${GIP} www.google.com.bd
${GIP} www.google.be
${GIP} www.google.bf
${GIP} www.google.bg
${GIP} www.google.com.bh
${GIP} www.google.bi
${GIP} www.google.bj
${GIP} www.google.com.bn
${GIP} www.google.com.bo
${GIP} www.google.com.br
${GIP} www.google.bs
${GIP} www.google.bt
${GIP} www.google.co.bw
${GIP} www.google.by
${GIP} www.google.com.bz
${GIP} www.google.ca
${GIP} www.google.com.kh
${GIP} www.google.cc
${GIP} www.google.cd
${GIP} www.google.cf
${GIP} www.google.cat
${GIP} www.google.cg
${GIP} www.google.ch
${GIP} www.google.ci
${GIP} www.google.co.ck
${GIP} www.google.cl
${GIP} www.google.cm
${GIP} www.google.cn
${GIP} www.google.com.co
${GIP} www.google.co.cr
${GIP} www.google.com.cu
${GIP} www.google.cv
${GIP} www.google.com.cy
${GIP} www.google.cz
${GIP} www.google.de
${GIP} www.google.dj
${GIP} www.google.dk
${GIP} www.google.dm
${GIP} www.google.com.do
${GIP} www.google.dz
${GIP} www.google.com.ec
${GIP} www.google.ee
${GIP} www.google.com.eg
${GIP} www.google.es
${GIP} www.google.com.et
${GIP} www.google.fi
${GIP} www.google.com.fj
${GIP} www.google.fm
${GIP} www.google.fr
${GIP} www.google.ga
${GIP} www.google.ge
${GIP} www.google.gf
${GIP} www.google.gg
${GIP} www.google.com.gh
${GIP} www.google.com.gi
${GIP} www.google.gl
${GIP} www.google.gm
${GIP} www.google.gp
${GIP} www.google.gr
${GIP} www.google.com.gt
${GIP} www.google.gy
${GIP} www.google.com.hk
${GIP} www.google.hn
${GIP} www.google.hr
${GIP} www.google.ht
${GIP} www.google.hu
${GIP} www.google.co.id
${GIP} www.google.iq
${GIP} www.google.ie
${GIP} www.google.co.il
${GIP} www.google.im
${GIP} www.google.co.in
${GIP} www.google.io
${GIP} www.google.is
${GIP} www.google.it
${GIP} www.google.je
${GIP} www.google.com.jm
${GIP} www.google.jo
${GIP} www.google.co.jp
${GIP} www.google.co.ke
${GIP} www.google.ki
${GIP} www.google.kg
${GIP} www.google.co.kr
${GIP} www.google.com.kw
${GIP} www.google.kz
${GIP} www.google.la
${GIP} www.google.com.lb
${GIP} www.google.com.lc
${GIP} www.google.li
${GIP} www.google.lk
${GIP} www.google.co.ls
${GIP} www.google.lt
${GIP} www.google.lu
${GIP} www.google.lv
${GIP} www.google.com.ly
${GIP} www.google.co.ma
${GIP} www.google.md
${GIP} www.google.me
${GIP} www.google.mg
${GIP} www.google.mk
${GIP} www.google.ml
${GIP} www.google.com.mm
${GIP} www.google.mn
${GIP} www.google.ms
${GIP} www.google.com.mt
${GIP} www.google.mu
${GIP} www.google.mv
${GIP} www.google.mw
${GIP} www.google.com.mx
${GIP} www.google.com.my
${GIP} www.google.co.mz
${GIP} www.google.com.na
${GIP} www.google.ne
${GIP} www.google.com.nf
${GIP} www.google.com.ng
${GIP} www.google.com.ni
${GIP} www.google.nl
${GIP} www.google.no
${GIP} www.google.com.np
${GIP} www.google.nr
${GIP} www.google.nu
${GIP} www.google.co.nz
${GIP} www.google.com.om
${GIP} www.google.com.pk
${GIP} www.google.com.pa
${GIP} www.google.com.pe
${GIP} www.google.com.ph
${GIP} www.google.pl
${GIP} www.google.com.pg
${GIP} www.google.pn
${GIP} www.google.com.pr
${GIP} www.google.ps
${GIP} www.google.pt
${GIP} www.google.com.py
${GIP} www.google.com.qa
${GIP} www.google.ro
${GIP} www.google.rs
${GIP} www.google.ru
${GIP} www.google.rw
${GIP} www.google.com.sa
${GIP} www.google.com.sb
${GIP} www.google.sc
${GIP} www.google.se
${GIP} www.google.com.sg
${GIP} www.google.sh
${GIP} www.google.si
${GIP} www.google.sk
${GIP} www.google.com.sl
${GIP} www.google.sn
${GIP} www.google.sm
${GIP} www.google.so
${GIP} www.google.st
${GIP} www.google.sr
${GIP} www.google.com.sv
${GIP} www.google.td
${GIP} www.google.tg
${GIP} www.google.co.th
${GIP} www.google.com.tj
${GIP} www.google.tk
${GIP} www.google.tl
${GIP} www.google.tm
${GIP} www.google.to
${GIP} www.google.tn
${GIP} www.google.com.tr
${GIP} www.google.tt
${GIP} www.google.com.tw
${GIP} www.google.co.tz
${GIP} www.google.com.ua
${GIP} www.google.co.ug
${GIP} www.google.co.uk
${GIP} www.google.com
${GIP} www.google.com.uy
${GIP} www.google.co.uz
${GIP} www.google.com.vc
${GIP} www.google.co.ve
${GIP} www.google.vg
${GIP} www.google.co.vi
${GIP} www.google.com.vn
${GIP} www.google.vu
${GIP} www.google.ws
${GIP} www.google.co.za
${GIP} www.google.co.zm
${GIP} www.google.co.zw
${YIP} www.youtube.com m.youtube.com youtubei.googleapis.com youtube.googleapis.com www.youtube-nocookie.com
${BIP} www.bing.com bing.com
EOF

# reset /etc/hosts
echo 'printf "# Host Addresses\n127.0.0.1 localhost\n::1 localhost ip6-localhost ip6-loopback\n\n" > /etc/hosts' >> /etc/fltr/cron_twice_daily.sh

# add Safe Search to /etc/hosts
echo "cat /etc/fltr/safesearch >> /etc/hosts" >> /etc/fltr/cron_twice_daily.sh

# DuckDuckGo Safe Search is a special case - see: https://www.reddit.com/r/duckduckgo/comments/8qwzyl/feature_request_allow_network_operators_for_force/
dig duckduckgo.com
dig safe.duckduckgo.com
echo 'printf "$(dig +short safe.duckduckgo.com | tail -n 1) www.duckduckgo.com duckduckgo.com\n\n" >> /etc/hosts' >> /etc/fltr/cron_twice_daily.sh

# activate Safe Search
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
    allow net 224.0.0.0/4 240.0.0.0/4 10.0.0.0/8 172.16.0.0/12 169.254.0.0/16 192.168.0.0/16 127.0.0.0/24
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

# networking config
sed -i 's/#net\.ipv4\.ip_forward=.*/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# force local DNS traffic through CoreDNS
echo "nameserver 127.0.0.1" > /etc/resolv.conf
sed -i 's/#prepend\sdomain-name-servers.*/prepend domain-name-servers 127.0.0.1;/' /etc/dhcp/dhclient.conf
> /etc/resolvconf/resolv.conf.d/head
> /etc/resolvconf/resolv.conf.d/tail

# use iptables vs. nftables for performance reasons
update-alternatives --set iptables /usr/sbin/iptables-legacy
update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy

# prevent SSH brute forcing
iptables -A INPUT -p tcp -s 224.0.0.0/4 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 240.0.0.0/4 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 10.0.0.0/8 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 172.16.0.0/12 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 169.254.0.0/16 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp -s 192.168.0.0/16 --dport ssh -j ACCEPT
iptables -A INPUT -p tcp --dport ssh -j REJECT

# force external DNS traffic through CoreDNS
iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT
iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT
iptables -t nat -A POSTROUTING -j MASQUERADE

# disable IPv6
ip6tables -I FORWARD -i eth0 -j REJECT

# save iptables settings
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6
systemctl start netfilter-persistent.service && systemctl enable netfilter-persistent.service

# install bettercap
cd /root
go get -u github.com/bettercap/bettercap
mv /root/go/bin/bettercap /usr/local/bin && rm -rf /root/go
