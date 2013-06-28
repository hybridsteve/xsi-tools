''''Author: Stephen Wagner
''''Version: 1.0
''''Cinemanix Productions
''''Release: 20070427

''''For 5.11
'''''''''''''''''''''''''''''''''''''''''''''


''''Script Prompt: Exporting to .fbx a mesh with multiple texture projections will crash XSI
''''Script Purpose: Dual. On first run, it should place all meshes with multiple texture projections into a group and alert the user to the name of the group so that the user can fix those problems.
''''On the second run, or if it finds no meshes with multiple texture projections, it should alert the user that the mesh(es) are safe to export to the format.



''''declare crap
dim oList, oAllClusters, numProjections, numBadMeshes, oGroup

numProjections = 0
numBadMeshes = 0


set oGroup = CreateGroup( "Meshes_With_Multiple_Projections" )


set oList = SelectAll( False, False )

for each item in oList
	if typename(item) = "X3DObject" then
		set oAllClusters = item.ActivePrimitive.Geometry.Clusters
		numProjections = 0
			for each cls in oAllClusters
				
				if cls.Type = "sample" then
					logmessage "projection cluster detected, incrementing super variable"
					numProjections = numProjections + 1
					logmessage "number of projections is " & numProjections
					
					if numProjections > 1 then
						numBadMeshes = numBadMeshes + 1
						AddToGroup oGroup, item
					else
						end if
				else
					logmessage "not a projection cluster"
					end if
			next
	else
		end if
next
logmessage "number of meshes that need to be fixed is " & numBadMeshes


if numBadMeshes < 1 then
	RemoveGroup( "Meshes_With_Multiple_Projections*" )
	msgbox "There are no meshes in the scene with multiple texture projections. Hell Yeah."
else
	msgbox "There are " & numBadMeshes & " meshes that need to be fixed in the scene."

end if 
