;keyboard shortcuts
;caplock to ctrl
CapsLock::Control
; changes insert into a toggle for WinMax and WinRestore
Insert::
  WinGet MX, MinMax, A
  If MX
	WinRestore A
  Else WinMaximize A
  return

#W::
  Run Firefox
  return
#E::
  Run Notepad
  return
#F::
  Run Explorer
  return
#T::
   Run cmd
  return
#X::
  Run Excel
^+V::
  clipboard = %clipboard%
  SendInput, ^v
  return

