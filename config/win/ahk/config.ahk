; Navigation

; vim like navigation
!j::Send "{Down}"
!k::Send "{Up}"
!h::Send "{Left}"
!l::Send "{Right}"
!n::Send "{PgDn}"
!p::Send "{PgUp}"

#j::Send "{Down}"
#k::Send "{Up}"
#h::Send "{Left}"
#l::Send "{Right}"
#n::Send "{PgDn}"
#p::Send "{PgUp}"

; keyboard Layout
CapsLock::Send "{Shift down}{Alt}{Shift up}"
F2::Send "{Alt down}{``}{Alt up}"
F1::Send "{Alt down}{``}{Alt up}"

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
