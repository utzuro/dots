# Git notes

## GitLab verified commits with GPG

### Check or create a GPG key

```sh
gpg --list-secret-keys --keyid-format=long
```

Use the long key ID from a line like:

```text
sec   ed25519/ABC123DEF4567890
```

If there is no suitable key, create one:

```sh
gpg --full-generate-key
```

Use the same email address as the GitLab account or commit email.

### Export the public key

```sh
gpg --armor --export ABC123DEF4567890
```

Copy the full output, including:

```text
-----BEGIN PGP PUBLIC KEY BLOCK-----
...
-----END PGP PUBLIC KEY BLOCK-----
```

### Add it to GitLab

Go to:

```text
User Settings -> GPG Keys -> Add new key
```

Paste the public key and save it.

The email in the GPG key must match a verified email on the GitLab account.

### Configure Git to sign commits

```sh
git config --global user.signingkey ABC123DEF4567890
git config --global commit.gpgsign true
git config --global user.email "you@example.com"
```

### Make a signed commit

```sh
git commit -S -m "test signed commit"
git push
```

GitLab should show the commit as verified.

### If signing fails

```sh
export GPG_TTY=$(tty)
```

Add that to the shell config if needed.

Check local signing:

```sh
echo test | gpg --clearsign
```
