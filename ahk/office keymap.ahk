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
  
  Run cmd /k cd "C:\Documents and Settings\niburns\Desktop\1.2.0"
  return
#X::
  Run Excel
  return
#Q::
  Run mstsc.exe
  return
#I::
  Run iexplore.exe
  return
#C::
  Run calc
  return
^+V::
  clipboard = %clipboard%
  SendInput, ^v
  return
;Inspired from WindowPad - http://www.autohotkey.com/forum/topic21703.html
;Switches Screen of ActiveWindow
#Enter::
  WinGet MX, MinMax, A
  If MX
    WinRestore A
  WinGetPos, X, Y, Width, Height, A
  ;on screen 2
  
  If X+Width/2>1280
  {
    If Height>940
	  WinMove,A,, X-1280, 0, Width, 963,,
    Else WinMove,A,, X-1280, Y
  }
  Else
  {
    If Height>940
	  WinMove,A,, X+1280, 0, Width, 1030,,
    Else WinMove,A,, X+1280, Y
  }
  If MX
    WinMaximize A
  return

;Songbird Global Hotkeys

^#Up::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -volumeup
	return
  }

^#Down::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -volumedown
	return
  }

^#V::Volume_Mute

^#Right::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -next
	return
  }

^#Left::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -previous
	return
  }

^#Space::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -pause
	return
  }
  
^#Return::
  Process, Exist, songbird.exe
  NewPID=%ErrorLevel%
  if NewPID {
	run "C:Program Files\Songbird\songbird.exe" -stop
	return
  }