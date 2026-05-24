# System suspend hook

Install the system unit for the target user:

```sh
sudo ln -sf "$PWD/config/systemd/suspend@.service" /etc/systemd/system/suspend@.service
sudo systemctl daemon-reload
sudo systemctl enable suspend@void.service
```
