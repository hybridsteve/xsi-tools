''''Stephen Wagner
''''Script Version 1.3
''''Cinemanix Productions
''''Release: 070518

''''Notes: Script to automate the creation of animation clips and then the exporting of those clips.
''''Notes: Still need make a new scene and not save current scene. 



''''prototype script
'=========================================

dim oRoot, oSpace, oSpace2, oString, oCount, oAction

DeselectAll


set oRoot = ActiveProject.ActiveScene.Root
set oSpace = oRoot.Children 
for each model in oSpace
    if typename(model) = "Model" then
        'AddToSelection model
        set oSpace = model
    else    
        end if
next

set oSpace2 = oSpace.Children 
for each model in oSpace2
if typename(model) = "Model" then
		DeselectAll
        SelectObj model, "BRANCH"
        set oSpace = model
        SelectChildNodes
    else    
        end if
next

''''the fun stuff=======================

'AddToSelection oSpace

set oCount = Selection
n = oCount.Count
nz = 1
logmessage "Ref_message: there are " & n & " objects selected" 

'for each item in Selection
'	oString = item & ".kine.local.posx," & item & ".kine.local.posy," & item & ".kine.local.posz," & item & ".kine.local.rotx," & item & ".kine.local.roty," & item & ".kine.local.rotz," & item & ".kine.local.sclx," & item & ".kine.local.scly," & item & ".kine.local.sclz" 
'	StoreAction , oString,  2, "StoredFcvAction", True, 0, 914, False, False, False, 0
'next

'''prototype superstring theory
'''=====================================

for each item in Selection
	if nz = 1 then
		oString = item & ".kine.local.posx," & item & ".kine.local.posy," & item & ".kine.local.posz," & item & ".kine.local.rotx," & item & ".kine.local.roty," & item & ".kine.local.rotz," & item & ".kine.local.sclx," & item & ".kine.local.scly," & item & ".kine.local.sclz" 
		nz = nz + 1
	else
		oString = oString & ", " & item & ".kine.local.posx," & item & ".kine.local.posy," & item & ".kine.local.posz," & item & ".kine.local.rotx," & item & ".kine.local.roty," & item & ".kine.local.rotz," & item & ".kine.local.sclx," & item & ".kine.local.scly," & item & ".kine.local.sclz"
		nz = nz + 1 '''this probably doesn't matter anymore wait yes it does'''
		end if
	if nz = n then
		StoreAction, oString, 2, "ScriptStoredFcvAction", True, 0, 914, False, False, False, 0
		logmessage "Script completed creation of clip."
		logmessage "Working from " & oSpace
	else
		end if
next

DeselectAll
SelectObj "*.Mixer.ScriptStoredFcvAction"
ExportAction (Selection)
DeleteObj "*.Mixer.ScriptStoredFcvAction"
