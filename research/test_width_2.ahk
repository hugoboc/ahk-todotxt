;#Include
;**************************************
Data=
(
Email First_Name Last_Name Title Another more more2
Joe@the-Automator.com Joe Glines the-Automator LastFound one End
joejunkemail@yahoo.com Jon King King big guy Here
Joe@AnotherDomain.com Joseph GLines Something now what ok
)

Data1=
(
ONE,TWO,THREE,FOUR,FIVE,SIX
1one,1two,1threeeeeeeeeeeeeeee,1four,1five,1six
2one,2two,2three,2four,2five,2six
)
LV_Table(Data1,",",1,Title:="Example Tab delimited data & not using header") ;comma on variable
;~ Data_Source3:=A_ScriptDir . "\data.txt"
;~ LV_Table(Data_Source3,,0,Title:="Example large tab delimited FILE not using header") ;tab on file

;~ LV_Table(Post, delimiter:="`t",UseHeader:=1,Title:="Joe's posts")
LV_Table(Data_Source, delimiter="`t",UseHeader=1,Title=""){ ; default delimiter set to tab
if FileExist(Data_Source) ;if file exists use it as source
FileRead, Data_Source, %Data_Source% ;read in and store as variable

;***********parse the data in variable and store in object*******************
data_obj := StrSplit(Data_Source,"`n","`r") ;parse earch row and store in object
rowHeader:=StrReplace(data_obj.RemoveAt(1),Delimiter,"|",Numb_Columns) ; Remove header from Object and convert to pipe delimited
if (useHeader=0){
loop, % Numb_Columns+1
RH.="Col_" A_Index "|"
rowHeader:=RH
}

dCols:= (Numb_Columns<8) ? 400: ((Numb_Columns<80) ? 650 : 1100) ;if cols <10 use 400; if cols <80 use 650 ; else use 1100
dRows:= (data_obj.MaxIndex() >27) ? 26 : data_obj.MaxIndex() ;if rows >27 use 26 else use # of rows

Gui, Table_View: New,,%Title% ;create new gui window and set title
Gui, Add, ListView, w%dCols% r%dRows% grid , % rowHeader ;set headers

For Each, Row In data_obj ;add the data lines to the ListView
LV_Add("", StrSplit(Row, Delimiter)*) ;LV_Add is a variadic function

Gui, Table_View:Show
}