# Windows setup

## Local user during install

shift+F10 + `start ms-cxh:localonly`

## Time

Config Windows to use UTC time, to avoid time traveling when dual-booting.

1.Goto:
-> HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\TimeZoneInformation

2.Right-click the "TimeZoneInformation" key and select New > DWORD (32-bit) Value.

3. Name your new value RealTimeIsUniversal.

4. Double-click the RealTimeIsUniversal value you just created, set is value data to 1, and click "OK".

## Install Scoop

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

## Other installs:

https://www.autohotkey.com/
https://git-scm.com/downloads/win
https://sourceforge.net/projects/eartrumpet.mirror/
