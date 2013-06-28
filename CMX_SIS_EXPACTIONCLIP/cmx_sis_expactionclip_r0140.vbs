''''Stephen Wagner
''''Script Version 1.41
''''Cinemanix Productions
''''Release: 070821

''''Notes: Script to automate the creation of animation clips and then the exporting of those clips.
''''Notes: Still need make a new scene and not save current scene. 
''''Now with default frame ranges!
''''documented



''''declare lists and deselect everything
'========================================

dim oRoot, oSpace, oSpace2, oString, oCount, oAction 

DeselectAll

''''set the scene root as the active space
'=========================================


set oRoot = ActiveProject.ActiveScene.Root

''''find and select the model null below the active space, twice, giving us the second model null down the hierarchy
'===================================================================================================================


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


''''set up incrementors and log number of objects
'================================================



set oCount = Selection
n = oCount.Count
nz = 1
logmessage "Ref_message: there are " & n & " objects selected" 



''''get proper parameters to store from each object, compile them into a single string for StoreAction, and store the new action
'===============================================================================================================================

for each item in Selection
	if nz = 1 then
		oString = item & ".kine.local.posx," & item & ".kine.local.posy," & item & ".kine.local.posz," & item & ".kine.local.rotx," & item & ".kine.local.roty," & item & ".kine.local.rotz," & item & ".kine.local.sclx," & item & ".kine.local.scly," & item & ".kine.local.sclz" 
		nz = nz + 1
	else
		oString = oString & ", " & item & ".kine.local.posx," & item & ".kine.local.posy," & item & ".kine.local.posz," & item & ".kine.local.rotx," & item & ".kine.local.roty," & item & ".kine.local.rotz," & item & ".kine.local.sclx," & item & ".kine.local.scly," & item & ".kine.local.sclz"
		nz = nz + 1 
		end if
	if nz = n then
		StoreAction, oString, 2, "ScriptStoredFcvAction", True, Default, Default, False, False, False, 0
		logmessage "Script completed creation of clip."
		logmessage "Working from " & oSpace
	else
		end if
next

''''deselect everything again, find the just-created action, and export it, then delete the action
'=================================================================================================

DeselectAll
SelectObj "*.Mixer.ScriptStoredFcvAction"
ExportAction (Selection)
DeleteObj "*.Mixer.ScriptStoredFcvAction"
