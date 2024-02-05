; Navigation

; windows
#f::WinMaximize "A"

; vim like navigation
!j::Send "{Down}"
!k::Send "{Up}"
!h::Send "{Left}"
!l::Send "{Right}"
!n::Send "{PgDn}"
!p::Send "{PgUp}"

; switch between windows
^j::Send "{Alt down}{Tab}{Alt up}"
^k::Send "{Alt down}{Shift down}{Tab}{Shift up}{Alt up}"

; Keyboard Layout
CapsLock::Send "{Shift down}{Alt}{Shift up}"
F2::Send "{Alt down}{``}{Alt up}"
F1::Send "{Alt down}{``}{Alt up}"

; Media keys
#m::Send "{Media_Play_Pause}"

; Open apps
#n::
{
    if WinExist("ahk_class Notepad")
        WinActivate 
    else
        Run "notepad"
}
#enter::Run "C:\Users\void\scoop\apps\git\current\git-bash.exe"

; Emulate numpad
!q::Send "{Numpad7}"
!w::Send "{Numpad8}"
!e::Send "{Numpad9}"
!a::Send "{Numpad4}"
!s::Send "{Numpad5}"
!d::Send "{Numpad6}"
!z::Send "{Numpad1}"
!x::Send "{Numpad2}"
!c::Send "{Numpad3}"

; Shortcuts overwriting

; macOS like shortcuts
#v::Send "^v"
#x::Send "^x"
#z::Send "^z"
#c::Send "^c"
#q::Send "{Alt down}{F4}{Alt up}"
^q::Send "{Alt down}{F4}{Alt up}"
; move between desktops with super + arrow keys
#Left::Send "{Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}"
#Right::Send "{Ctrl down}{LWin down}{Right}{LWin up}{Ctrl up}"

; Text shortcuts
>!s::Send "ы"
::ue::Unreal Engine 5
