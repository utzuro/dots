; Navigation

; vim like navigation
!j::Send "{Down}"
!k::Send "{Up}"
!h::Send "{Left}"
!l::Send "{Right}"
!n::Send "{PgDn}"
!p::Send "{PgUp}"

; Switch between windows
; ^j::Send "{Alt down}{Tab}{Alt up}"
; ^k::Send "{Alt down}{Shift down}{Tab}{Shift up}{Alt up}"


; Keyboard Layout
CapsLock::Send "{Shift down}{Alt}{Shift up}"
F2::Send "{Alt down}{``}{Alt up}"
F1::Send "{Alt down}{``}{Alt up}"


; Open apps
#n::
{
    if WinExist("ahk_class Notepad")
        WinActivate 
    else
        Run "notepad"
}
#enter::Run "C:\Program Files\Git\git-bash.exe"


; Shortcuts overwriting

; media keys
#m::Send "{Media_Play_Pause}"

; kill app
#q::Send "{Alt down}{F4}{Alt up}"
#+q::Send "{Alt down}{F4}{Alt up}"

; move between desktops with super + arrow keys
#Left::Send "{Ctrl down}{LWin down}{Left}{LWin up}{Ctrl up}"
#Right::Send "{Ctrl down}{LWin down}{Right}{LWin up}{Ctrl up}"

; Text shortcuts
>!s::Send "ы"
; ::ue::Unreal Engine 5
