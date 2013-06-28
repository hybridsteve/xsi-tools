''''Author: Stephen Wagner
''''Version 1.0
''''Cinemanix Productions
''''Release: 20070504

''''For XSI 5.11
''''Notes: Deletes all clusters in a scene
''''this is the greatest and best script in the world

''''==================================================

dim oGroup, oCount


DeselectAll
n = 0
m = 0
on error resume next
SelectObj "*.cls.*"
set oGroup = Selection


Function ClusterBomb( cluster_group )
n = cluster_group.Count
logmessage "There are " & cluster_group.Count & " clusters selected."
for each thing in cluster_group
	DeleteObj thing
	n = n - 1
	m = m + 1
next
logmessage " " & m & " clusters deleted from the scene."

if n > 0 then
	logmessage "Script completed. There are still " & n & " clusters remaining in the scene. Script is running again."
	
	DeselectAll
	n = 0
	m = 0
	'''on error resume next
	SelectObj "*.cls.*"
	set oGroup = Selection
	
	Call ClusterBomb( oGroup )

else
	msgbox "Script completed. There are no more clusters in the scene."
	end if
End Function

Call ClusterBomb( oGroup )
