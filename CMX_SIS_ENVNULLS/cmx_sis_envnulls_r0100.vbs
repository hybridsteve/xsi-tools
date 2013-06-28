''''Author: Stephen Wagner
''''Requested: Matt Kapfhammer
''''Version: 1.0
''''Cinemanix Productions
''''Release: 20071914
''''Language: VBScript

''''For XSI 5.11 on Windows 2k/XP
'=============================================================

'Abstract: Script uses selected bones to create nulls that are
'matched to the transforms of those bones and appear as boxes.

'Script Use: Select a rig or hierarchy of bones (non-bones will
'not be affected) and run the script. The new nulls will be 
'children of a "ENV_Root" null that is a child of the scene root.
'The nulls will have no primary icon, but will have a shadow icon
'that looks like a box.

'NOTE: If you have an "ENV_Root" in the scene already, make sure
'you remove or rename it, as it will interfere with the script.

'Version History: First release.

'=============================================================

dim oRigItems, oBone, oNull, oNewRootNull

set oRigItems = Application.Selection
oCount = oRigItems.count
logmessage "Number of items selected is " & oCount

set oNewRootNull = ActiveSceneRoot.AddNull("ENV_Root")


for each oItem in oRigItems
	oCloneNullFromBone( oItem )
next

DeselectAll


function oCloneNullFromBone( oInputBone )
	if oInputBone.Type = "bone" then
		oNull = oNewRootNull.AddNull("ENV_"&oInputBone.Name)
		MatchTransform oNull, oInputBone, siSRT
		logmessage "Working from " & oInputBone
		logmessage "Created null " & oNull
		SetValue oNull & ".null.primary_icon",0
		SetValue oNull & ".null.shadow_icon",4
	else
	end if
end function

'PseudoCode
'===============================================================

'create lists

'set list oRigItems to the current selection
'count the number of things in oRigItems
'log a message of the number of things
'
'create a new null under the root called "ENV_Root"
'
'
'for each thing in oRigItems
'	run the function oCloneNullFromBone
'next
'
'Deselect all objects
'
'
'Define function oCloneNullFromBone( first argument )
'	if the object sent to the function is a bone then
'		add a new null underneath "ENV_Root" and set oNull to that null
'		match the transforms of oNull to the bone that was sent to the function
'		log a message about the bone
'		log a message about the new null
'		set the null's primary display to "none"
'		set the null's shadow display to "box"
'	else
'	end if
'end the function