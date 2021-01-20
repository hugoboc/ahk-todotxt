#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Gui, 1: Color, 008880
Gui, 1: +Border +Caption -Disabled +LastFound +MinimizeBox +MaximizeBox +OwnDialogs +Resize +SysMenu +Theme -ToolWindow

Loop, read, todo_example.txt
{
    Loop, parse, A_LoopReadLine, %A_Tab%
    {
        ;MsgBox, %A_LoopField%.
		Gui, 1: Add, Text, w600 ,%A_LoopField%
    }
}

;Gui, Add, Text, ,%A_LoopField%
Gui, 1: Show, w620