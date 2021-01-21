; Create the ListView with two columns, Name and Size:
Gui, Add, ListView, r20 w900 gMyListView, Name
Gui, +Border +Caption -Disabled +LastFound +MinimizeBox +MaximizeBox +OwnDialogs +Resize +SysMenu +Theme -ToolWindow


/*
	Loop, read, todo_example.txt
	{
		Loop, parse, A_LoopReadLine, %A_Tab%
		{
		   ;MsgBox, %A_LoopField%.
			Gui, 1: Add, Text, w600 ,%A_LoopField%
		}
	}
*/

; Gather a list of file names from a folder and put them into the ListView:
Loop, read, C:\Users\CabritaH\OneDrive - Ardagh Group\01_hugo_stuff\06_git_repositories\ahk-todotxt\todo_example.txt
LV_Add("", A_LoopReadLine)
LV_ModifyCol(Auto)  ; Auto-size each column to fit its contents.
LV_ModifyCol(2, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

; Display the window and return. The script will be notified whenever the user double clicks a row.
Gui, Show
return

MyListView:
if (A_GuiEvent = "DoubleClick")
{
    LV_GetText(RowText, A_EventInfo)  ; Get the text from the row's first field.
    ToolTip You double-clicked row number %A_EventInfo%. Text: "%RowText%"
}
return

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp