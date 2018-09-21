#!/bin/bash
# The script scrapes out facebook's IP addresses using OriginAS
# Installed and tested this on IPFire Firewall, a RedHat based firewall
# Can be used in other websites as well

/sbin/iptables -N FACEBOOK
for f in `whois -h whois.radb.net '!gAS32934'|grep /|tr " " "\n"|sort|un
do
  /sbin/iptables -A FACEBOOK -d $f -p tcp -m tcp -j DROP
done
/sbin/iptables -A FACEBOOK -j RETURN
/sbin/iptables -I FORWARD -j FACEBOOK
/sbin/iptables -I OUTPUT -j FACEBOOK

