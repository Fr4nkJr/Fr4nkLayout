#Requires AutoHotkey v2.0

; Caps改为Ctrl，Shift+Esc为大写锁定
CapsLock::Ctrl
+Esc::CapsLock

; Alt+IJKL控制光标移动
!i::Up
!j::Left
!k::Down
!l::Right

; 设置切换停用脚本的快捷键
#SuspendExempt
+CapsLock::Suspend
