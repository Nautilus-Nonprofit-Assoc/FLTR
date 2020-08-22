#!/bin/bash

echo "** RESULTS **" > results.txt

(dig google.com | grep -q "NOERROR" && echo "DNS test 1/2: PASS" || echo "DNS test 1/2: FAIL") >> results.txt
(dig badexample.com | grep -q "NXDOMAIN" && echo "DNS test 2/2: PASS" || echo "DNS test 2/2: FAIL") >> results.txt
(dig sigok.verteiltesysteme.net +dnssec | grep -q "NOERROR" && echo "DNSSEC test 1/2: PASS" || echo "DNS test 1/2: FAIL") >> results.txt
(dig sigfail.verteiltesysteme.net +dnssec | grep -q "SERVFAIL" && echo "DNSSEC test 2/2: PASS" || echo "DNS test 2/2: FAIL") >> results.txt
(dig testentry.rpz.urlhaus.abuse.ch | grep -q "NXDOMAIN" && echo "SafeSearch test 1/2: PASS" || echo "SafeSearch test 1/2: FAIL") >> results.txt
(getent ahosts duckduckgo.com | grep -q $(dig +short safe.duckduckgo.com | tail -n 1) && echo "SafeSearch test 2/2: PASS" || echo "SafeSearch test 2/2: FAIL") >> results.txt
(curl -s -L -m 5 http://example.com | grep -q "illustrative" && echo "curl test: PASS" || echo "curl test: FAIL") >> results.txt



cat results.txt && rm results.txt
