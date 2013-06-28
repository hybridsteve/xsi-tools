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

aAddParameter = ("Prefix","Prefix","Suffix","Suffix","After Char","After Char")
  

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
oPSet.AddParameter3("sAddParameter",c.siString)
oPSet.AddParameter3("sAddPosition",c.siUInt2)
oPSet.AddParameter3("sAddCharacter",c.siString)
oPSet.AddParameter3("sRemove",c.siString)
oPSet.AddParameter3("sPreview",c.siString)
oPSet.AddParameter3("vCaseMethod",c.siString)

xsi.SetValue("cmx_namer.Namer.sPreview", "Preview the name change here.")
xsi.SetValue("cmx_namer.Namer.sFind", "")

#create layout
oLayout = oPSet.PPGLayout
oLayout.Language = "PythonScript"
#begin first tab========================================================
oLayout.AddTab("Find and Replace")
#find group-------------------------------------------------------------
oLayout.AddGroup("Find String", true)
oLayout.AddRow()
oItem = oLayout.AddItem("sFind","Find:",c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("FindInSel", "Find In Selection")
oItem = oLayout.AddButton("FindAll", "Find All")
oLayout.EndRow()

oLayout.EndGroup()
#replace group-----------------------------------------------------------
oLayout.AddGroup("Replace String", true)
oLayout.AddRow()
oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oLayout.EndRow()
oLayout.AddRow()
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

#begin second tab===========================================================
oLayout.AddTab("Add and Remove")
#add group
oLayout.AddGroup("Add String")
oLayout.AddRow()
oItem = oLayout.AddItem("sAdd", "Add String:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddItem("sAddParameter", "Add Method:", c.siControlRadio)
oItem.UIItems = aAddParameter
oLayout.EndRow()

oLayout.AddRow()
oItem = oLayout.AddItem("sAddCharacter","Character:", c.siControlString)
oItem.SetAttribute(c.siUIWidthPercentage, 50)
oItem = oLayout.AddItem("sAddPosition","Char# or Position:", c.siControlString)
oItem.SetAttribute(c.siUIWidthPercentage, 50)
oLayout.EndRow()

oLayout.AddRow()
oItem = oLayout.AddButton("AddToSelected", "Add To Selected")
oItem= oLayout.AddButton("AddToAll", "Add To All")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oLayout.EndRow()
oLayout.AddRow()
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
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("GenPreview_REM", "Generate Preview")
oLayout.EndRow()

oLayout.EndGroup()


#begin third tab===========================================================
oLayout.AddTab("Case Tools")


#add logic to the property page
oLayout.Logic = """
from win32com.client import constants as c
from string import count, replace, split
xsi = Application
log = xsi.LogMessage
#import re

#begin find and replace stuff===========================

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
    if (vFindString != ""):
        for thing in oSelection:
            vNewName = replace(thing.Name,vFindString,vReplaceString)
            thing.Name = vNewName
    else:
        buttonPressed = XSIUIToolkit.Msgbox("Do you really want to do this?", c.siMsgYesNo, "No find string!")
        if (buttonPressed == c.siMsgYes):
            for thing in oSelection:
                vNewName = replace(thing.Name,vFindString,vReplaceString)
                thing.Name = vNewName

def GenPreview_FR_OnClicked():
    i = 0
    vFindString = xsi.GetValue("cmx_namer.Namer.sFind")
    vReplaceString = xsi.GetValue("cmx_namer.Namer.sReplace")
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        while (i == 0):
            vNewName = replace(thing.Name,vFindString,vReplaceString)
            xsi.SetValue("cmx_namer.Namer.sPreview", "Preview: " + vNewName)
            log("DEBUG: Creating preview...%s" % vNewName)
            i += 1
           
#end find and replace stuff==========================
#begin add and remove stuff==========================

def AddToSelected_OnClicked():
    vAddString = xsi.GetValue("cmx_namer.Namer.sAdd")
    vAddParameter = xsi.GetValue("cmx_namer.Namer.sAddParameter")
    oSelection = xsi.GetValue("SelectionList")
    if (vAddParameter == "") or (vAddParameter == "Prefix"):
        for thing in oSelection:
            vNewName = vAddString + thing.Name
            thing.Name = vNewName
            
    elif (vAddParameter == "Suffix"):
        for thing in oSelection:
            vNewName = thing.Name + vAddString
            thing.Name = vNewName
            
    elif (vAddParameter == "After Char"):
        vAddChar = xsi.GetValue("cmx_namer.Namer.sAddCharacter")
        vAddPos = xsi.GetValue("cmx_namer.Namer.sAddPosition")
        if (vAddChar == ""):
            for thing in oSelection:
                vCount = len(thing.Name)
                vNewName = thing.Name[0:vAddPos] + vAddString + thing.Name[vAddPos:vCount]
                thing.Name = vNewName
        else:
            for thing in oSelection:
                i = 0
                vCount = (thing.Name).count(vAddChar)
                vLength = len(thing.Name)
                oldPrefLength = 0
                vNewPref = ""
                vNewSuff = thing.Name
                while (i < vAddPos) and (vAddPos <= vCount):
                    vPrefLength = (vNewSuff).find(vAddChar)
                    log("DEBUG: " + str(vPrefLength))
                    vNewPref = vNewPref + vNewSuff[0:vPrefLength+1]
                    log("DEBUG1: " + vNewPref)
                    vNewSuff = thing.Name[len(vNewPref):vLength]
                    log("DEBUG2: " + vNewSuff)
                    i += 1
                thing.Name = vNewPref+vAddString+vNewSuff

def AddToAll_OnClicked():            
    vAddString = xsi.GetValue("cmx_namer.Namer.sAdd")
    vAddParameter = xsi.GetValue("cmx_namer.Namer.sAddParameter")
    xsi.SelectAll()
    oSelection = xsi.GetValue("SelectionList")
    xsi.DeselectAll()
    if (vAddParameter == "") or (vAddParameter == "Prefix"):
        for thing in oSelection:
            vNewName = vAddString + thing.Name
            thing.Name = vNewName
            
    elif (vAddParameter == "Suffix"):
        for thing in oSelection:
            vNewName = thing.Name + vAddString
            thing.Name = vNewName
            
    elif (vAddParameter == "After Char"):
        vAddChar = xsi.GetValue("cmx_namer.Namer.sAddCharacter")
        vAddPos = xsi.GetValue("cmx_namer.Namer.sAddPosition")
        if (vAddChar == ""):
            for thing in oSelection:
                vCount = len(thing.Name)
                vNewName = thing.Name[0:vAddPos] + vAddString + thing.Name[vAddPos:vCount]
                thing.Name = vNewName
        else:
            for thing in oSelection:
                i = 0
                vCount = (thing.Name).count(vAddChar)
                vLength = len(thing.Name)
                oldPrefLength = 0
                vNewPref = ""
                vNewSuff = thing.Name
                while (i < vAddPos) and (vAddPos <= vCount):
                    vPrefLength = (vNewSuff).find(vAddChar)
                    log("DEBUG: " + str(vPrefLength))
                    vNewPref = vNewPref + vNewSuff[0:vPrefLength+1]
                    log("DEBUG1: " + vNewPref)
                    vNewSuff = thing.Name[len(vNewPref):vLength]
                    log("DEBUG2: " + vNewSuff)
                    i += 1
                thing.Name = vNewPref+vAddString+vNewSuff

                
def RemoveFromSelected_OnClicked():
	vRemoveString = xsi.GetValue("cmx_namer.Namer.sRemove")
	oSelection = xsi.GetValue("SelectionList")
	for thing in oSelection:
		vNewNameList = (thing.Name).split(vRemoveString,2)
		#log("DEBUG1: " + str(vNewNameList))
		vNewName = str(vNewNameList[0]) + str(vNewNameList[1])
		#log("DEBUG2: " + str(vNewName))
		thing.Name = vNewName

def RemoveAll_OnClicked():
	vRemoveString = xsi.GetValue("cmx_namer.Namer.sRemove")
	xsi.SelectAll()
	oSelection = xsi.GetValue("SelectionList")
	xsi.DeselectAll()
	for thing in oSelection:
		vCount = count(thing.Name, vRemoveString)
		if (vCount != 0):
			vNewNameList = (thing.Name).split(vRemoveString,2)
			#log("DEBUG1: " + str(vNewNameList))
			vNewName = str(vNewNameList[0]) + str(vNewNameList[1])
			#log("DEBUG2: " + str(vNewName))
			thing.Name = vNewName

	
"""

#bring up the custom ppg
xsi.InspectObj(oPSet)