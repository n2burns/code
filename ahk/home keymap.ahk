;keyboard shortcuts
;caplock to ctrl
CapsLock::Control
;Menu key to Win
AppsKey::RWin
; changes insert into a toggle for WinMax and WinRestore
Insert::
  WinGet MX, MinMax, A
  If MX
	WinRestore A
  Else WinMaximize A
  return

#W::
  Run Chrome
  return
#Z::
  Run "C:\Users\n2burns\AppData\Local\Google\Chrome\Application\chrome.exe"
  return
#E::
  Run "C:\Program Files (x86)\Notepad++\notepad++.exe"
  return
#F::
  Run Explorer
  return
#T::
  Run cmd.exe
  return
#X::
  Run Excel
;from http://programmerproductivity.wordpress.com/2007/04/21/4/
^+V::
  clipboard = %clipboard%
  SendInput, ^v
  return
;#Q::
;  Run gvim
;  return
#M::
  Run songbird
  return
#C::
  Run calc
  return

;volume and media
; #^Up::
  ; run "C:Program Files (x86)\Songbird\songbird.exe" -volumeup
  ; return
; #^Down::
  ; run "C:Program Files (x86)\Songbird\songbird.exe" -volumedown
  ; return
; #^V::Volume_Mute
; #^Right::
  ; run "C:Program Files (x86)\Songbird\songbird.exe" -next
  ; return
; #^Left::
  ; run "C:Program Files (x86)\Songbird\songbird.exe" -previous
  ; return
; #^Space::
  ; run "C:Program Files (x86)\Songbird\songbird.exe" -pause
  ; return

;From taskbar-overload.ahk [http://www.ocellated.com/2009/06/04/taskbar-overlord/]

;Handle middle clicks on Windows 7 Taskbar to close all windows for a given icon
;********************************************************************************
	
MButton::
	CoordMode, Mouse, Screen
	MouseGetPos, x, y, WinUnderMouseID
	;WinActivate, ahk_id %WinUnderMouseID%

;Get y position relative to the bottom of the screen.
yBottom := A_ScreenHeight - y

	; Close taskbar program on middle click, if click on a taskbar icon
	if yBottom <= 60 ;40
	{
		BlockInput On
		Send, +{Click %x% %y% right} ;shift right click
		Sleep, 100
		Send, C ;send c which is Close All Windows
		WinWaitNotActive, ahk_class Shell_TrayWnd,, 0.5 ; wait for save dialog, etc
		If ErrorLevel = 1
			Send, {Escape} ;hides context menu if no program icon clicked.
		BlockInput Off
	; else send normal middle click
	} else {
		If GetKeyState("MButton") {	;The middle button is physically down
			MouseClick, Middle,,,0,D 		;middle button down
			KeyWait, MButton				;to allow dragging
			MouseClick, Middle,,,,0,U		;release middle button up
		} Else {
			MouseClick, Middle,,
		}
	 }
	 
Return