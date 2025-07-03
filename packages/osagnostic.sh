# rss
printf "\n⌛... Installing and configuring OS agnostic pkgs... 📂\n"

printf "\n⌛... installing RSS... 🖥\n"
go install github.com/TypicalAM/goread@latest

printf "\n⌛... installing dictionaries... 🖥\n"
go install github.com/masakichi/tango@latest
echo
echo "📝 Import Japanese dictionaries with: tango -import... 📚"

