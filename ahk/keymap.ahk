;keymap.ahk
;keyboard shortcuts

^+NumpadEnter::
^+Enter::
  KeyWait Control
  KeyWait Shift
  Send {Enter}{Enter}======================================{Enter}{Enter}
  return
^+Space::
  KeyWait Control
  KeyWait Shift
  Send {Enter}{Enter}--------------------------------------{Enter}{Enter}
  return
CapsLock::return
Insert::return
#C::
  Run calc
  return
;add shortcuts to disable insert, cap locks