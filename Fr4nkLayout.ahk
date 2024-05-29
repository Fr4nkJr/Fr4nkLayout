#SingleInstance force
#MaxHotkeysPerInterval 100
#UseHook
Process, Priority,, Realtime
SetKeyDelay -1

Menu, Tray, NoStandard
Menu, Tray, Tip, 键盘布局 - Fr4nk
Menu, Tray, Add, 切换 (&Q), MenuSuspend
Menu, Tray, Add, 切换 (&Q), MenuSuspend
Menu, Tray, Add, 退出 (&E), MenuExit
Menu, Tray, Default, 切换 (&Q)
Menu, Tray, Click, 1
Suspend Off
If (!A_IsCompiled) {
  Menu, Tray, Icon, D.ico, 1, 1
}

return

MenuExit:
  ExitApp

MenuSuspend:
  Suspend Permit
  if (A_IsSuspended) {
    Suspend Off
    If (!A_IsCompiled) {
      Menu, Tray, Icon, D.ico, 1, 1
    }
    Menu, Tray, Tip, 键盘布局 - Fr4nk
  } else {
    Suspend On
    If (!A_IsCompiled) {
      Menu, Tray, Icon, Q.ico, 1, 1
    }
    Menu, Tray, Tip, 键盘布局 - QWERTY
  }
  return

*RAlt::
  Suspend Permit
  if (!p) {
    p := true
    old := A_IsSuspended
    nbsp := false
    ck := A_TimeSincePriorHotkey
    pRAlt := A_PriorHotkey = "*RAlt up"
  }
  Suspend On
  Menu, Tray, Tip, 键盘布局 - QWERTY
  If (!A_IsCompiled) {
    Menu, Tray, Icon, Q.ico, 1, 1
  }
  return

*RAlt up::
  Suspend Permit
  Send {RAlt Up}
  p := false
  if (!(((ck < 200) && (ck > 0) && pRAlt) || (nbsp && old))) {
    Suspend Off
    Menu, Tray, Tip, 键盘布局 - Fr4nk
    If (!A_IsCompiled) {
      Menu, Tray, Icon, D.ico, 1, 1
    }
  } 
  return

; 以下为保留qwerty常用快捷键设置
^w::^w
^a::^a
^f::^f
^x::^x
^c::^c
^v::^v


; 以下为个人Carpalx QFMLWY键位配置
!1::Send {1}
!2::Send {2}
!3::Send {3}
!4::Send {4}
!5::Send {5}
!6::Send {6}
!7::Send {7}
!8::Send {8}
!9::Send {9}
!0::Send {0}

1::+=
2::=
3::+9
4::[
5::+[
6::+7
7::+8
8::+1
9::+3
0::+]




~RCtrl::
	if IsDoubleClick() {
		RemapKeys := !RemapKeys
		if RemapKeys
			ShowTransText("数字模式")
		else
			ShowTransText()
	}
return

#If RemapKeys
    1::1
    2::2
    3::3
    4::4
    5::5
    6::6
    7::7
    8::8
    9::9
    0::0
    +1::+=
    ;+2::=
    +2::
    KeyWait Shift
    Send {=}
    return
    +3::+9
    +4::
    KeyWait Shift
    Send {[}
    return
    +5::+[
    +6::+7
    +7::+8
    +8::+1
    +9::+3
    +0::+]
#If

IsDoubleClick() {
	static doubleClickTime := DllCall("GetDoubleClickTime")
	KeyWait, % LTrim(A_ThisHotkey, "~")
	return (A_ThisHotKey = A_PriorHotKey) && (A_TimeSincePriorHotkey <= doubleClickTime)
}

; ShowTransText("Hello")
; ShowTransText("Hello", 10, 10, {bgColor:"0x1482DE", textColor:"White"})
ShowTransText(Text := "", X := 0, Y := 0, objOptions := "") {
	if (Text = "") {
		Gui, @STT_:Destroy
		return
	}

	o := {bgColor:"Black", textColor:"0x00ff00", transN:200, fontSize:12}
	for k, v in objOptions {
		o[k] := v
	}
	
	Gui, @STT_:Destroy
	Gui, @STT_:+AlwaysOnTop -Caption -SysMenu +ToolWindow +E0x20 +HWNDhGUI
	Gui, @STT_:Font, % "s" o.fontSize
	Gui, @STT_:Color, % o.bgColor
	Gui, @STT_:Add, Text, % "c" o.textColor, %Text%
	Gui, @STT_:Show, x%X% y%Y% NA
	WinSet, Transparent, % o.transN, ahk_id %hGUI%
}


-::+5
+-::
KeyWait Shift
Send {]}
return
=::+\
+=::+0


w::f
e::m
r::l
t::w
y::.
i::o
o::b
p::j
[::+-
+[::+6
]::+2
+]::+4
\::\
+\::
KeyWait Shift
Send {``}
return

a::d
d::t
f::n
g::r
h::i
j::a
k::e
l::h

x::v
c::g
v::c
b::x
n::p
m::k
.::y
RShift::-
+RShift::+`

;键盘不改键需要的指令(Caps改为退格,Shift+Esc改为Caps)
CapsLock::Backspace
+Esc::CapsLock

; Alt+IJKL控制光标移动
!i::Send {Up}
!j::Send {Left}
!k::Send {Down}
!l::Send {Right}


Enter::Enter
Space::
  Suspend Permit
  nbsp := true
  if (p) {
    Send #{Space}
  } else {
    Send {Space}
  }
  return
