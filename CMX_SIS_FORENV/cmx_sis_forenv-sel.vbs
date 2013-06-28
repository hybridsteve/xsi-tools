''''Author: Chrystia Siolkowsky
''''Version: 1.0
''''Cinemanix Productions
''''Release Date: 070415

''''Release Notes: Creates and enveloping group for bones from a selection.

for i = 1 to 3
	for each item in Selection
		if typename(item) = "ChainRoot" Then
			ToggleSelection item, , True
		elseif typename(item) = "ChainEffector" Then
			ToggleSelection item, , True
		end if
	next
next

CreateGroup
SetValue "Group.Name", "For_Enveloping"