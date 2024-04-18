echo
echo "⌛... Configuring EC2 Workspace ... 🖳"
DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit ; pwd -P )"

./shell_install.sh

sudo yum install ranger
sudo yum install -y gcc kernel-devel make ncurses-devel

