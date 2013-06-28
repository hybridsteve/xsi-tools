#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Major Version: 01
#Minor Version: 42
#Cinemanix Productions
#Release: 070821
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================

'''
Abstract: creates an animation clip from a model using the default frame ranges
(earliest frame with animation data to latest), and exports the resulting action
with a user prompt for name and location...
'''

'''
ISSUE: 'Default' frame ranges are not accepted. This is either due to
python+xsi requiring some other enum for defaults, or due to the file
I'm using having no animation, or some other unforseen circumstance. Need
to get a proper scene with imported fbx animation on the rig, as per our
pipeline, and test properly.

Version History: 0142: Fixed issues with python, some other bad scripting
'''
#import constants, declare normals and deselect everything
#=============================================================

from win32com.client import constants as c

true = 1
false = 0
oRoot = Application.ActiveSceneRoot
xsi = Application
log = xsi.LogMessage

xsi.DeselectAll()

#find and select the model null below the active space, twice,
#giving us the second model null down the hierarchy
#=============================================================

oSpace = oRoot.Children
for thing in oSpace:
    log("DEBUG: " + str(thing.Type))
    if (thing.Type == "#model"):
        #AddToSelection model
        oSpace = thing

oSpace2 = oSpace.Children 
for model in oSpace2:				
    if (model.Type == "#model"):
        xsi.DeselectAll()
        xsi.SelectObj(model, "BRANCH")
        oSpace = model
        xsi.SelectChildNodes()

#set up incrementors and log number of objects
#================================================

oCount = xsi.Selection
n = oCount.Count
nz = 1
log("Ref_message: there are " + str(n) + " objects selected")



#get proper parameters to store from each object, compile them into a single string for StoreAction, and store the new action
#===============================================================================================================================

oSList = xsi.GetValue("SelectionList")
for item in oSList:
    if (nz == 1):
        oString = (item.Name + ".kine.local.posx," + item.Name + ".kine.local.posy," + item.Name + ".kine.local.posz," + item.Name + ".kine.local.rotx," + item.Name + ".kine.local.roty," + item.Name + ".kine.local.rotz," + item.Name + ".kine.local.sclx," + item.Name + ".kine.local.scly," + item.Name + ".kine.local.sclz")
        nz = nz + 1
    else:
        oString = (oString + ", " + item.Name + ".kine.local.posx," + item.Name + ".kine.local.posy," + item.Name + ".kine.local.posz," + item.Name + ".kine.local.rotx," + item.Name + ".kine.local.roty," + item.Name + ".kine.local.rotz," + item.Name + ".kine.local.sclx," + item.Name + ".kine.local.scly," + item.Name + ".kine.local.sclz")
        nz = nz + 1 

    if (nz == n):
        xsi.StoreAction(oSpace, oString, 2, "ScriptStoredFcvAction", True, '', '', False, False, False, 0)
        log("Script completed creation of clip.")
        log("Working from " + str(oSpace))

#deselect everything again, find the just-created action, and export it, then delete the action
#=================================================================================================

xsi.DeselectAll()
xsi.SelectObj("*.Mixer.ScriptStoredFcvAction")
xsi.ExportAction(xsi.Selection)
xsi.DeleteObj("*.Mixer.ScriptStoredFcvAction")
