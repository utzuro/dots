# 1) backup current network config
uci export network >/root/network.pre-gamewith.$(date +%F-%H%M%S).uci

# 2) make sure WAN is explicitly the physical WAN port
uci set network.wan.device='eth0'
uci set network.wan.proto='dhcp'

# 3) rebuild wan6 directly on eth0
uci set network.wan6='interface'
uci set network.wan6.device='eth0'
uci set network.wan6.proto='dhcpv6'
uci set network.wan6.reqaddress='try'
uci set network.wan6.reqprefix='auto'
uci set network.wan6.peerdns='1'

uci commit network

# 4) bring only WAN pieces back up; avoid full restart for now
ifdown wan6 2>/dev/null
ifup wan
ifup wan6

sleep 10

# 5) inspect result
ifstatus wan
ifstatus wan6
ifstatus lan
ip -6 addr show dev eth0
ip -6 addr show dev br-lan
ip -6 route show
logread -e odhcp6c -e wan6
