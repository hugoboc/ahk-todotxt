text:="Hello World"
Resizable_GUI(text,100,100)

Resizable_GUI(Data,x=900,y=600){
	static EditWindow
	Gui,12:Destroy
	Gui,12:Default
	Gui,+Resize
	Gui,Font,s12 cBlue q5, Courier New
	Gui,Add,Edit,w%x% h%y% -Wrap HScroll hwndEditWindow, %Data%
	Gui,Show
	return
	12GuiEscape:
	12GuiClose:
	Gui,12:Destroy
	return
	12GuiSize:
	GuiControl,12:Move,%EditWindow%,% "w" A_GuiWidth-30 " h" A_GuiHeight-25
	return
	}