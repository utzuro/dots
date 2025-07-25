# rss
printf "\n⌛... Installing and configuring OS agnostic pkgs... 📂\n"

printf "\n⌛... installing NodeJS... 🖥\n"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 22
node -v

printf "\n⌛... installing RSS... 🖥\n"
go install github.com/TypicalAM/goread@latest

printf "\n⌛... installing dictionaries... 🖥\n"
go install github.com/masakichi/tango@latest
echo
echo "📝 Import Japanese dictionaries with: tango -import... 📚"

