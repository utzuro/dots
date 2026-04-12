#!/bin/sh

# Implements ds-lite communication basically adding Crosspass support to the router.
# Creates the tunnel to deliver ipv4 packets over ipv6, registers the ipv6 address so ISP could forward assigned ipv4 to it.
# Registeres static ipv4 assigned by the ISP
# This script is meant to run every 10m and on restart, to keep changes persistent.

TAG="xpass"

# ---- interface/device names ----
LAN_DEV="br-lan" # This could default to something else, recheck which interface has the global ipv6
TUN_DEV="xpass"  # Custom name

# ---- ISP values ----
REMOTE6="YOUR_TUNNEL_DESTINATION_IPV6" # usually starts with '2001:...'
PUBLIC4="YOUR_PUBLIC_IPV4"
DDNS_URL="https://YOUR_DDNS_UPDATE_URL"
BASIC_USER="YOUR_BASIC_AUTH_ID"
BASIC_PASS="YOUR_BASIC_AUTH_PASSWORD"
DDNS_D="YOUR_D_VALUE"
DDNS_P="YOUR_DDNS_PASSWORD"
DDNS_U="YOUR_U_VALUE"

# ---- tunnel MTU ----
MTU="1460"

# simple lock to avoid overlapping runs
LOCKDIR="/tmp/xpass-refresh.lock"
if ! mkdir "$LOCKDIR" 2>/dev/null; then
	exit 0
fi
trap 'rmdir "$LOCKDIR"' EXIT

get_local6() {
	ip -6 addr show dev "$LAN_DEV" scope global 2>/dev/null |
		awk '/inet6 / {print $2}' |
		cut -d/ -f1 |
		head -n1
}

LOCAL6="$(get_local6)"

if [ -z "$LOCAL6" ]; then
	logger -t "$TAG" "no global IPv6 on $LAN_DEV yet"
	exit 1
fi

# 1) Refresh DDNS.
DDNS_OUT="$(
	curl -6ksS --basic --user "$BASIC_USER:$BASIC_PASS" --get "$DDNS_URL" \
		--data-urlencode "d=$DDNS_D" \
		--data-urlencode "p=$DDNS_P" \
		--data-urlencode "a=$LOCAL6" \
		--data-urlencode "u=$DDNS_U" 2>&1
)"
DDNS_RC=$?

if [ "$DDNS_RC" -ne 0 ]; then
	logger -t "$TAG" "DDNS update failed rc=$DDNS_RC: $DDNS_OUT"
else
	echo "$DDNS_OUT" | grep -q 'Success'
	if [ "$?" -eq 0 ]; then
		logger -t "$TAG" "DDNS updated to $LOCAL6"
	else
		logger -t "$TAG" "DDNS response did not contain Success: $DDNS_OUT"
	fi
fi

# 2) Ensure tunnel exists with the current local IPv6 and expected remote IPv6.
TSHOW="$(ip -6 tunnel show "$TUN_DEV" 2>/dev/null || true)"
echo "$TSHOW" | grep -F "$LOCAL6" | grep -F "$REMOTE6" >/dev/null 2>&1
if [ "$?" -ne 0 ]; then
	ip -6 tunnel del "$TUN_DEV" 2>/dev/null || true
	ip -6 tunnel add "$TUN_DEV" mode ipip6 local "$LOCAL6" remote "$REMOTE6"
	logger -t "$TAG" "created tunnel local=$LOCAL6 remote=$REMOTE6"
fi

# 3) Bring tunnel up and restore IPv4-on-tunnel + default route.
ip link set "$TUN_DEV" mtu "$MTU" up

if ! ip -4 addr show dev "$TUN_DEV" | grep -q "inet $PUBLIC4/32"; then
	ip addr flush dev "$TUN_DEV" scope global
	ip addr add "$PUBLIC4/32" dev "$TUN_DEV" # manually assign static ipv4 provided by the ISP
	logger -t "$TAG" "assigned IPv4 $PUBLIC4/32 on $TUN_DEV"
fi

ip route replace default dev "$TUN_DEV"

logger -t "$TAG" "refresh complete local6=$LOCAL6 public4=$PUBLIC4"
exit 0
