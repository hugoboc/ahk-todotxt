#SingleInstance,Force ;make sure it only runs once

:*:gg:: ;when I type gg bring up the menu (* means don't wait for an end charachter)
TextMenu("This is, cool;But I like;to do more;with these;But that's about`n`nit")
return

:*:ff:: ;when I type gg bring up the menu (* means don't wait for an end charachter)
TextMenu("this;is from the;ff choice I typed;Pretty cool;huh")
return

TextMenu(TextOptions){
for k, MenuItems in StrSplit(TextOptions,";") ;parse the data on the weird pipe charachter
Menu, MyMenu,Add,% MenuItems,Action ;Add each item to the Menu
Menu, MyMenu, Show ;Display the GUI and wait for action
Menu, MyMenu, DeleteAll ;Delete all the menu items
}
Action:
ClipboardBackup:=ClipboardAll ;backup clipboard
Clipboard:=A_ThisMenuItem ;Shove what was selected into the clipboard
Send, ^v ;paste the text
sleep, 50 ;Remember to sleep before restoring clipboard or it will fail
Clipboard:=ClipboardBackup ;Restore clipboard
return