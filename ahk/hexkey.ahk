;Hexkey.ahk
;
;Script to toggle Hexidemical Keypad on press of NumLock
;TODO ASCII map of what we're doing


; -- -- -- --
;|NL| /| *| -|
; -- -- -- --
;| 7| 8| 9| +|
; -- -- -- 
;| 4| 5| 6|  |
; -- -- -- --
;| 1| 2| 3|CR|
; -- -- -- 
;| 0   | .|  |
; -- -- -- --
 
 
;  -- -- -- --
;| A| B| C| D|
; -- -- -- --
;| 7| 8| 9| E|
; -- -- -- 
;| 4| 5| 6|  |
; -- -- -- --
;| 1| 2| 3| F|
; -- -- -- 
;| 0   | :|  |
; -- -- -- --

Suspend
; numlock toggles this script
ScrollLock::Suspend
; hex keys
NumLock::A
NumpadDiv::B
NumpadMult::C
NumpadSub::D
NumpadAdd::E
NumpadEnter::F
NumpadDel:::
NumpadDot:::


;TODO toggle scrlk light (maybe capslock too) with toggle of this script