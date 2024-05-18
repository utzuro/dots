 export WINEARCH=win64
 export WINEPREFIX=$HOME/.wine-battlenet
 winetricks dxvk

# wine64 Battle.net-Setup.exe
wine64 ~/.wine-battlenet/drive_c/Program\ Files\ \(x86\)/Battle.net/Battle.net.exe
