#!/bin/bash

echo "** RESULTS **" > results.txt

(cat /etc/resolv.conf | grep -q 127.0.0.1 && echo "resolv test 1/2: PASS" || echo "resolv test 1/2: FAIL") >> results.txt
(test $(cat /etc/resolv.conf | wc -l) -eq 1 && echo "resolv test 2/2: PASS" || echo "resolv test 2/2: FAIL") >> results.txt
(dig @127.0.0.1 google.com | grep -q NOERROR && echo "DNS test 1/3: PASS" || echo "DNS test 1/3: FAIL") >> results.txt
(dig @$(hostname -I | cut -d' ' -f1) google.com | grep -q NOERROR && echo "DNS test 2/3: PASS" || echo "DNS test 2/3: FAIL") >> results.txt
(dig badexample.com | grep -q NXDOMAIN && echo "DNS test 3/3: PASS" || echo "DNS test 3/3: FAIL") >> results.txt
(dig sigok.verteiltesysteme.net +dnssec | grep -q NOERROR && echo "DNSSEC test 1/2: PASS" || echo "DNS test 1/2: FAIL") >> results.txt
(dig sigfail.verteiltesysteme.net +dnssec | grep -q SERVFAIL && echo "DNSSEC test 2/2: PASS" || echo "DNS test 2/2: FAIL") >> results.txt
(dig testentry.rpz.urlhaus.abuse.ch | grep -q NXDOMAIN && echo "SafeSearch test 1/2: PASS" || echo "SafeSearch test 1/3: FAIL") >> results.txt
(getent ahosts www.google.com | grep -q $(dig +short forcesafesearch.google.com | tail -n 1) && echo "SafeSearch test 2/3: PASS" || echo "SafeSearch test 2/2: FAIL") >> results.txt
(getent ahosts duckduckgo.com | grep -q $(dig +short safe.duckduckgo.com | tail -n 1) && echo "SafeSearch test 3/3: PASS" || echo "SafeSearch test 2/2: FAIL") >> results.txt
(lsmod | grep -qw ipv6 && echo "IPv6 block test: FAIL" || echo "IPv6 block test: PASS") >> results.txt
(ulimit -Hn | grep -q 4194304 && echo "sysctl test 1/2: PASS" || echo "sysctl test 1/2: FAIL") >> results.txt
(ulimit -Hl | grep -q unlimited && echo "sysctl test 2/2: PASS" || echo "sysctl test 2/2: FAIL") >> results.txt
(coredns --version | grep -q "CoreDNS" && echo "CoreDNS test: PASS" || echo "CoreDNS test: FAIL") >> results.txt
(bettercap -version | grep -q "bettercap v2" && echo "bettercap test: PASS" || echo "bettercap test: FAIL") >> results.txt
EXAMPLEIP="$(dig +short example.com)"
APPLEIP="$(dig +short captive.apple.com | tail -n 1)"
APPLECIDR="$(dig +short captive.apple.com | tail -n 1 | cut -d. -f-3).0/24"
(curl -sm 1 example.com | grep -q "illustrative" && echo "oxdpus test 1/7: PASS" || echo "oxdpus test 1/7: FAIL") >> results.txt
(curl -sm 1 captive.apple.com | grep -q "Success" && echo "oxdpus test 2/7: PASS" || echo "oxdpus test 2/7: FAIL") >> results.txt
(test $(oxdpus list | wc -l) -gt 100 && echo "oxdpus test 3/7: PASS" || echo "oxdpus test 3/7: FAIL") >> results.txt
oxdpus add --ip=$EXAMPLEIP > /dev/null 2>&1
oxdpus add --ip=$APPLECIDR > /dev/null 2>&1
(curl -sm 1 example.com | grep -q "illustrative" && echo "oxdpus test 4/7: FAIL" || echo "oxdpus test 4/7: PASS") >> results.txt
(curl -sm 1 captive.apple.com | grep -q "Success" && echo "oxdpus test 5/7: FAIL" || echo "oxdpus test 5/7: PASS") >> results.txt
oxdpus remove --ip=$EXAMPLEIP > /dev/null 2>&1
oxdpus remove --ip=$APPLECIDR > /dev/null 2>&1
(curl -sm 1 example.com | grep -q "illustrative" && echo "oxdpus test 6/7: PASS" || echo "oxdpus test 6/7: FAIL") >> results.txt
(curl -sm 1 captive.apple.com | grep -q "Success" && echo "oxdpus test 7/7: PASS" || echo "oxdpus test 7/7: FAIL") >> results.txt



cat results.txt && rm results.txt
