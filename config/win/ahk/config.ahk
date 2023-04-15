#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; LANG
*CapsLock::
    Send, {LWin down}{Space}{Lwin up}
    return

;NAVIGATION
Alt & j::AltTab
Alt & k::ShiftAltTab

; NUMLOCK
!q::
    send, {Numpad7}
    return
!w::
    send, {Numpad8}
    return
!e::
    send, {Numpad9}
    return
!a::
    send, {Numpad6}
    return
!s::
    send, {Numpad5}
    return
!d::
    send, {Numpad4}
    return
!z::
    send, {Numpad1}
    return
!x::
    send, {Numpad2}
    return
!c::
    send, {Numpad3}
    return
!r::
    send, {Numpad0}
    return

; Multimedia
#m::
    send, {Media_Play_Pause}
    return


; Text
::ue::Unreal Engine 5

; links
#+u::
    Run, https://duckduckgo.com/?t=ffab&q=unreal+engine+5&ia=web
