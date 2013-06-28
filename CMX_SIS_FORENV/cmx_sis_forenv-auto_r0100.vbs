''''Author: Chrystia Siolkowsky
''''Version: 1.0
''''Cinemanix Productions
''''Release Date: 070415

''''Release Notes: This script gathers ALL the bones in your scene and adds them to a group
''''called FOR_ENVELOPING. If you have two rigs in the scene, it will take the bones from both
''''of them and add them to the group, so they will need to be separated before any enveloping can
''''be done.

set oRoot = ActiveSceneRoot
set oChild = ActiveSceneRoot.FindChildren()
for each child in oChild
	if typename(child) = "ChainBone" Then
		ToggleSelection child, , True
	end if
next

CreateGroup
SetValue "Group.Name", "For_Enveloping"