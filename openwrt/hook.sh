#!/bin/sh
# Creates a hook that runs the script every time settings could disappear

cat >/etc/hotplug.d/iface/95-xpass-refresh <<'EOF'
#!/bin/sh

case "$ACTION" in
  ifup|ifupdate) ;;
  *) exit 0 ;;
esac

case "$INTERFACE" in
  lan|wan6) ;;
  *) exit 0 ;;
esac

# On ifupdate, only react when something meaningful changed.
if [ "$ACTION" = "ifupdate" ] && \
   [ -z "$IFUPDATE_ADDRESSES$IFUPDATE_PREFIXES$IFUPDATE_ROUTES$IFUPDATE_DATA" ]; then
    exit 0
fi

/root/ds-lite.sh >/dev/null 2>&1 &
EOF

chmod 755 /etc/hotplug.d/iface/95-xpass-refresh
