#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Version: 0.4
#Cinemanix Productions
#Release: 000
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================

"""Abstract: the beginnings of an xsi cmx pipeline re/namer function,
that will include a wide variety of ranaming and naming options."""

"""Script Use: Either select or find and select based on names, one
or several objects, and then perform any number of operations on the
names of those objects."""

#=============================================================

from win32com.client import constants as c
#from string import *

true = 1
false = 0
lFoundObjects = 0
lSelectionList = 0
sRenamePreview = 0

oRoot = Application.ActiveSceneRoot
xsi = Application
log = xsi.LogMessage

aAddParameter = ( "Front","Front"
                  "End","End"
                  "After Char","After Char")
    

try:
    xsi.DeleteObj("cmx_namer")
except Exception:
    log("doi")

oScriptNull = oRoot.AddNull("cmx_namer")
oPSet = oScriptNull.AddProperty("CustomProperty",false,"Namer")

#add parameters to the parameter set
oPSet.AddParameter3("sFind",c.siString)
oPSet.AddParameter3("sReplace",c.siString)
oPSet.AddParameter3("sAdd",c.siString)
oPSet.AddParameter3("sAddParameter",c.siUInt2)
oPSet.AddParameter3("sAddPosition",c.siUInt2)
oPSet.AddParameter3("sAddCharacter",c.siString)
oPSet.AddParameter3("sRemove",c.siString)
oPSet.AddParameter3("sPreview",c.siString)
oPSet.AddParameter3("vCaseMethod",c.siString)

#create layout
oLayout = oPSet.PPGLayout
oLayout.Language = "PythonScript"
#begin first tab
oLayout.AddTab("Find and Replace")
#find group
oLayout.AddGroup("Find String", true)
oLayout.AddRow()
oItem = oLayout.AddItem("sFind","String to Find",c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("FindInSel", "Find In Selection")
oItem = oLayout.AddButton("FindAll", "Find All")
oLayout.EndRow()

oLayout.EndGroup()
#replace group
oLayout.AddGroup("Replace String", true)
oLayout.AddRow()
oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oItem = oLayout.AddButton("GenPreview_FR", "Generate Preview")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
oItem = oLayout.AddItem("sReplace","Replace With:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("Replace", "Replace in Selected")
oLayout.EndRow()

oLayout.EndGroup()

#begin second tab
oLayout.AddTab("Add and Remove")
#add group
oLayout.AddGroup("Add String")
oLayout.AddRow()
oItem = oLayout.AddItem("sAdd", "Add String:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("AddToSelected", "Add To Selected")
oItem= oLayout.AddButton("AddToAll", "Add To All")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oItem = oLayout.AddButton("GenPreview_ADD", "Generate Preview")
oLayout.EndRow()
oLayout.EndGroup()
#remove group
oLayout.AddGroup("Remove String")
oLayout.AddRow()
oItem = oLayout.AddItem("sRemove", "Remove String:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("RemoveFromSelected", "Remove From Selected")
oItem= oLayout.AddButton("RemoveAll", "Remove From All")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oItem = oLayout.AddButton("GenPreview_REM", "Generate Preview")
oLayout.EndRow()

oLayout.EndGroup()


#begin third tab
oLayout.AddTab("Case Tools")


#add logic to the property page
oLayout.Logic = """#multiline strings own
from string import count, replace
xsi = Application
log = xsi.LogMessage
#import re
def FindInSel_OnClicked():
    oSelection = xsi.GetValue("Selectionlist")
    vFindString = xsi.GetValue("cmx_namer.Namer.sFind")
    log("DEBUG: Finding objects whos name contains %s" % vFindString)
    for thing in oSelection:
        if count(thing.Name, vFindString) < 1:
            xsi.RemoveFromSelection(thing)

def FindAll_OnClicked():
    vFindString = xsi.GetValue("cmx_namer.Namer.sFind")
    xsi.SelectAll()
    oSelection = xsi.GetValue("SelectionList")
    xsi.DeselectAll()
    for thing in oSelection:
        if count(thing.Name, vFindString) >= 1:
            xsi.AddToSelection(thing)
           
def Replace_OnClicked():
    vFindString = xsi.GetValue("cmx_namer.Namer.sFind")
    vReplaceString = xsi.GetValue("cmx_namer.Namer.sReplace")
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        vNewName = replace(thing.Name,vFindString,vReplaceString)
        thing.Name = vNewName

"""

#bring up the custom ppg
xsi.InspectObj(oPSet)