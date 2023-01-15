echo
echo "⌛... Configuring Linux ... 🖳"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

# Set up user groups:
echo
echo "⌛... Adding user to a necessary groups... 👥"
if [ -n "$USER" ]; then USER=$(whoami); fi
sudo usermod -aG input "$USER"
sudo usermod -aG docker "$USER"
sudo usermod -aG plugdev "$USER"
sudo usermod -aG vboxusers "$USER"
sudo usermod -aG lp "$USER" # bluetooth

# Generic packages:
go install github.com/masakichi/tango@latest
echo
echo "📝 Import Japanese dictionaries with: tango -import... 📚"

