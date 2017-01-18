exist=iptables-save | grep -- "-A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT"
echo $exist