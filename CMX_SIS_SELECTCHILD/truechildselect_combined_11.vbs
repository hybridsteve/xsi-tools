''''Author: Stephen Wagner
''''Requested: Matt Kapfhammer
''''Version: 1.1
''''Cinemanix Productions
''''Release: 20071917
''''Language: VBScript

''''For XSI 5.11 on Windows 2k/XP
'=============================================================

'Abstract: Script to select all the children of an object, or to
'recursively select all children of children of children (and so 
'on) of a selected object.

'LEFT MOUSE BUTTON: Select immediate children
'CTRL + LEFT MOUSE BUTTON: Select all children

'Script Use: Run the script on your selected objects to truly
'select all of thier children. This is the combined script that
'contains the code for either one iteration of selection and for
'a massive recursive child selection. 



'Version History: Second release. Adds requested functionality,
'where the script begins a pick session, with the left mouse 
'button selecting immediate children and CTRL + left mouse button
'selecting all children

'=============================================================

dim oSpace, oChildren, rButton, rPicked, rMod


'=============================================================
function TrueChildSelect( rflag )
if rflag = 1 then
	for each thing in Selection
		on error resume next
		AddToSelection thing.Children
	next
else
	for each thing in oSpace
		on error resume next
		AddToSelection thing.children
	next
end if
end function
'=============================================================



PickObject "Select Immediate Children", "[CTRL + LMB] Select All Children" , rPicked, rButton, rMod
DeselectAll
SelectObj rPicked
logmessage rPicked
set oSpace = GetValue("SelectionList")

if rButton = 1 then
	if rMod = 2 then
		logmessage "debug SELECT ALL CHILDREN CTRL"
		TrueChildSelect( 1 )
	else
		logmessage "debug SELECT IMMEDIATE CHILDREN"
		TrueChildSelect( 0 )
		end if
end if