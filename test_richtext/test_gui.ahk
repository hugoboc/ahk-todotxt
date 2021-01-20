#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#NoEnv
SetBatchLines, -1
#include Class_RichEdit.ahk
#Include %A_ScriptDir%

Search_Strings := "+OSS_L4,@Bodymaker"
Search_Text =
(
[COOLANT_PUMP_BM3G] +OSS_L4 @Bodymaker: 07.12.2020 email sent to Jansen for quote, waiting for reply  - 10.12.2020 reminder sent, waiting for reply - 15.12.2020 got quote and placed in SAP, also asked Basinski for quote, waiting for reply - 17.12.2020 asked for quote at Egger pumps, waiting for reply due:2020-12-18
)

appname := "SimpleRichEdit"
gosub, mainui
gosub, loadhotkeys
return
;------------------------------
mainui:
   Gui, +Hwnd%appname%
   Gui, Font, s9 q5, Arial
   MyRichEdit := new richedit(%appname%,"w680 h480 vmyedit", true)
   MyRichEdit.AlignText(2) ; align right
   MyRichEdit.SetText(Search_Text)
   Gui, Show, h500 w700 center,%appname%
Return
;------------------------------
Message:
   guicontrolget, myedit
   ToolTip, My contents are %myedit%
   settimer, removemessage, 1000
return
RemoveMessage:
	settimer, removemessage, off
	tooltip
return
;------------------------------
LoadHotkeys:
	hotkey, IfWinActive, % "ahk_id " %appname% ; <------
	hotkey, ^b, MakeBold
	hotkey, ^+b, MakeBold_alt
	hotkey, ^g, MakeColoured
	hotkey, ^t, Message
	hotkey, ^q, Clear
return
;-----------------------------------------------------------------------------------------------------------------------------------
; Mark search phrases red and bold
f3::
   CurrentSel := MyRichEdit.GetSel()                     ; get the current selection
   CF2 := MyRichEdit.GetCharFormat()                     ; retrieve a CHARFORMAT2 object
   CF2.Mask := 0x40000001                                ; set Mask (CFM_COLOR = 0x40000000, CFM_BOLD = 0x00000001)
   CF2.TextColor := 0x0000FF                             ; set TextColor to red (colors are BGR)
   CF2.Effects := 0x01                                   ; set Effects to bold (CFE_BOLD = 0x00000001)
   For Each, Phrase In StrSplit(Search_Strings, ",") {   ; process the search strings one by one
      MyRichEdit.SetSel(0, 0)                            ; start searching at the begin of the text
      While (MyRichEdit.FindText(Phrase, ["Down"]) <> 0) ; find the phrase
         MyRichEdit.SetCharFormat(CF2)                   ; apply the new settings
}
CF2 := ""                                             ; release the CF2 object
MyRichEdit.SetSel(CurrentSel.S, CurrentSel.E)         ; restore the previous selection
MyRichEdit.ScrollCaret()                              ; scroll the caret into view
Return

;------------------------------
;For syntax using the richtext tags:
;http://www.pindari.com/rtf1.html

;Demonstrate using the class' built-in ToggleFontStyle for the current selection
MakeBold:
MyRichEdit.ToggleFontStyle("B")
return

;Demonstrate setting of tag-styled text
MakeBold_alt:
MyRichEdit.ToggleFontStyle("B")
MyRichEdit.SetText("{\rtf some  text } `n {\rtf more text}", ["SELECTION"])
MyRichEdit.ToggleFontStyle("B")
MyRichEdit.SetText(" `n", ["SELECTION"])
MyRichEdit.SetText(A_Now "`n", ["SELECTION"])
	;~ MyRichEdit.SetText(" `n", ["SELECTION"])
Return

MakeColoured:
colortable := "{\colortbl `;\red0\green176\blue80;\red0\green77\blue187`;\red255\green0\blue0`;}"
greentext := "\cf1 green text,\cf0"
bluetext := "\cf2  blue text,\cf0"
redtext := "\cf3  red text\cf0"
MyRichEdit.ToggleFontStyle("B")
MyRichEdit.ToggleFontStyle("I")
MyRichEdit.SetText("{\rtf " . colortable . "Colouized text: " . redtext . " Colouized text: " ".} `n ", ["SELECTION"])
MyRichEdit.SetText("`n", ["SELECTION"])
return

Clear:
MyRichEdit.SetText("")
return
;------------------------------
GuiClose:
Gui, Destroy
ExitApp
return