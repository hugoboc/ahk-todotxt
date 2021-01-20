#singleinstance, force
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



FileList =
Gui, +Border +Caption -Disabled +LastFound +MinimizeBox +MaximizeBox +OwnDialogs +Resize +SysMenu +Theme -ToolWindow
Gui, Add, ListView, r40 w400 gMyListView, Time|Age|Name|Path
Loop, todo_example.txt, 0
   {
   CheckAge := A_LoopFileTimeModified
   EnvSub, CheckAge , A_Now , Minutes
   CheckAge := CheckAge * -1
   FormatTime, TimeMod, %A_LoopFileTimeModified%, yyyy-MM(MMM)-dd   HH:mm:ss
   LV_Add("",TimeMod,checkage,A_LoopFileName,A_LoopFileLongPath)
   }
Loop % LV_GetCount("Column")
{
   LV_ModifyCol(A_Index)
   LV_ModifyCol(A_Index, "AutoHdr")
}   
LV_ModifyCol(2, "Logical Sort Right")
Gui, Show,
return

MyListView:
if A_GuiEvent = DoubleClick
{
    LV_GetText(RowText, A_EventInfo, 4)  ; Get the text from the row's first field.
    Run, %RowText%
}
return


esc::exitapp 

GuiClose:  ; Indicate that the script should exit automatically when the window is closed.
ExitApp