# Debian Secure Script by c2_
# Environment: no Systemd, tested Debian 7.7
# Execute:
# \bash ash.sh
# What it does:
# 1.  Unalias all alias
# 2.  Corrects path
# 3.  Remove immutable lock on /etc/passwd & /etc/shadow
# 4.  Uses busybox to edit /etc/passwd root's shell
# 5.  Remove immutable lock on ~/.bash_profile & ~/.bashrc
# 6.  Stops common services: cron, netcat, ssh, telnet, samba
# 7.  Set Max simultaneous Logins for root, copys current config to .old
# 8.  Creates Blank file
# 9.  Cleans out repository and bashprofile startup scripts
# 10. Makes a directory for iptables
# 11. Begin adding firewall rules
# 12. Save rules to /etc/iptables/rulez & /var/iptables/rulez
# 13. Adjusts repository
# 14. Patches/Updates
# 15. Install tools and compilers
# 16. Download Artillery, Configure, Install, Start
# 17. Removes wget, make, flux
# 18. Clean unneeded packages

\unalias -a
\export $PATH=/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/bin:/usr/local/sbin
\chattr -i /etc/passwd
\chattr -i /etc/shadow
\/bin/busybox sed -i '1s/.*/root:x:0:0:root:\/root:\/bin\/bash/' /etc/passwd
\chattr -i ~/.bash_profile
\chattr -i ~/.bashrc
\rm -r ~/.bash_profile
\rm -r ~/.bashrc
\/etc/init.d/cron stop
\update-rc.d cron disable
\/etc/init.d/netcat stop
\update-rc.d/netcat disable
\/etc/init.d/ssh stop
\update-rc.d/ssh disable
\/etc/init.d/telnet stop
\update-rc.d/telnet disable
\/etc/init.d/samba stop
\update-rc.d/samba disable
\cp /etc/security/limits.conf /etc/security/limits.conf.old
\chmod 444 /etc/security/limits.conf.old
\chattr +i /etc/security/limits.conf.old
\rm -r /root/blank*
\touch /root/blank.txt
\cp -r /root/blank.txt /etc/apt/sources.list 
\cp -r /root/blank.txt ~/.bash_profile
\cp -r /root/blank.txt /etc/security/limits.conf
\/bin/busybox echo "* hard maxsyslogins 1">> /etc/security/limits.conf
\/bin/busybox echo "* soft maxlogins 1">> /etc/security/limits.conf
\chattr +i /etc/security/limits.conf
\mkdir /etc/iptables
\mkdir /var/iptables
\iptables --flush
\iptables -P INPUT ACCEPT
\iptables -P FORWARD ACCEPT
\iptables -P OUTPUT ACCEPT
\iptables -t nat -F
\iptables -t mangle -F
\iptables -F
\iptables -X
\iptables -A INPUT -i lo -j ACCEPT
\iptables -A INPUT ! -i lo -d 127.0.0.0/8 -j REJECT
\iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
\iptables -A INPUT -p tcp --dport 80 -j ACCEPT
\iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#iptables -A INPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p tcp -s $teamIP1 --sport 1024:65535 -d $IPaddress --dport $hostport1 -m state --state NEW,ESTABLISHED -j ACCEPT
\iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
\iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j REJECT
\iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables denied: " --log-level 7
\iptables -A INPUT -j REJECT
\iptables -A FORWARD -j REJECT
\iptables -A OUTPUT -j ACCEPT
\iptables -S > /etc/iptables/rulez
\iptables -S > /var/iptables/rulez
\/bin/busybox sed -i '1s/.*/*filter/' /etc/iptables/rulez
\/bin/busybox echo "COMMIT" >> /etc/iptables/rulez
\iptables-save
\/bin/busybox echo "deb http://ftp.us.debian.org/debian/ wheezy main" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://ftp.us.debian.org/debian/ wheezy main" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://security.debian.org/ wheezy/updates main" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://security.debian.org/ wheezy/updates main" >> /etc/apt/sources.list
\/bin/busybox echo "deb http://ftp.us.debian.org/debian/ wheezy-updates main" >> /etc/apt/sources.list
\/bin/busybox echo "deb-src http://ftp.us.debian.org/debian/ wheezy-updates main" >> /etc/apt/sources.list
#echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
#echo "deb-src http://packages.dotdeb.org wheezy all">> /etc/apt/sources.list
\apt-get update -y
\apt-get upgrade -y
\apt-get install wget nano make g++ bison flex git python sed htop libpcre3-dev zlib1g-dev libpcap-dev -y
\cd /tmp
\rm -r /tmp/artillery
\git clone https://github.com/trustedsec/artillery
\/bin/busybox sed -i '15s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '16s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '17s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '18s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '19s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '20s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '21s/.*/ /' /tmp/artillery/setup.py
\/bin/busybox sed -i '22s/.*/answer = "yes"/' /tmp/artillery/setup.py
\/bin/busybox sed -i '69s/.*/        choice = "yes"/' /tmp/artillery/setup.py 
\/bin/busybox sed -i '91s/.*/    choice = "yes"/' /tmp/artillery/setup.py 
\/bin/busybox sed -i '93s/.*/    if is_posix():' /tmp/artillery/setup.py 
\/bin/busybox rm -r /var/artillery
python /tmp/artillery/setup.py
#echo "Add Whitelist IPs Ex: 192.168.0.22, etc;Press Enter to Edit Config(Nano), Remember to save"
#read $pressEnter
#nano +33 /var/artillery/config
\ cd /var/artillery
\/bin/busybox sed -i '18s/.*/MONITOR_FOLDERS="\/proc","\/sys","\/sh","\/tmp","\/home","\/dev","\/lib","\/lib64","\/opt","\/run","\/srv","\/var\/www","\/etc","\/var","\/bin","\/sbin","\/usr","\/boot"/' /var/artillery/config
\/bin/busybox sed -i '30s/.*/HONEYPOT_BAN="ON"/' /var/artillery/config
\/bin/busybox sed -i '69s/.*/SSH_BRUTE_ATTEMPTS="1"/' /var/artillery/config
\/bin/busybox sed -i '72s/.*/FTP_BRUTE_MONITOR="ON"/' /var/artillery/config
\/bin/busybox sed -i '75s/.*/FTP_BRUTE_ATTEMPTS="1"/' /var/artillery/config
#echo "Edit Bind Interface, Example: 192.168.0.22;press Enter to Edit Config(Nano), Remember to save"
#read $pressEnter
#nano +97 /var/artillery/config
\python /var/artillery/restart_server.py
\apt-get remove wget* make* flex* -y
\echo "TODO: Artillery is installed & activated, Adjust Whitelist in: /var/artillery/config then restart_server.py"
\echo "TODO: Change shells of Games, Nobody, and any other that uses /bin/bash to /bin/false"
\echo "TODO: Tweak Firewall rules, save rules"
\echo "TODO: Check ~/.mysql_history"
\echo "TODO: Check History"
\apt-get clean
\apt-get autoclean
\apt-get autoremove
\chattr +i /etc/passwd
\chattr +i /etc/shadow

