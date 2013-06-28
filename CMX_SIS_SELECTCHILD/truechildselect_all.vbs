''''Author: Stephen Wagner
''''Requested: Matt Kapfhammer
''''Version: 1.0
''''Cinemanix Productions
''''Release: 20071917
''''Language: VBScript

''''For XSI 5.11 on Windows 2k/XP
'=============================================================

'Abstract: Script to select all the children of an object, or to
'recursively select all children of children of children (and so 
'on) of a selected object.

'Script Use: Run the script on your selected objects to truly
'select all of their children. This is the combined script that
'contains the code for either one iteration of selection and for
'a massive recursive child selection. 

'NOTE: THIS VERSION SELECTS ALLLLLL CHILDREN OF THE
'SELECTED OBJECT. MAKE A BUTTON

'Version History: First release.

'=============================================================

dim oSpace, oChildren

set oSpace = GetValue("SelectionList")

function TrueChildSelect(  )


for each thing in Selection
	on error resume next
	AddToSelection thing.children
next



end function

TrueChildSelect(  )