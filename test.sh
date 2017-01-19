
if [ -z iptables-save -t nat | grep -- 'OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600' ] then
    iptables -t nat -I OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
    echo 'Added tcp'
else
    echo 'Existed tcp'
fi
if [ -z iptables-save -t nat | grep -- 'OUTPUT -d 127.0.0.1/32 -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600' ] then
    iptables -t nat -I OUTPUT -d 127.0.0.1/32 -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
    echo 'Added udp'
else
    echo 'Existed udp'
fi