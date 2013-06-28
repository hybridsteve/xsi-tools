#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Major Version: 00
#Minor Version: 09
#Cinemanix Productions
#Release: 000
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================

"""Abstract: Large PPG that houses many many options for finding,
replacing, naming, renaming, adding, and removing things from the
names of objects.

Script Use: Either select or find and select based on names, one
or several objects, and then perform any number of operations on the
names of those objects.

Version History :0009: removed gen_preview sections from the interface, added selectchild
                    to interface (will not work outside of mator)
                 0008: added number padding thingie
                 0007: custom property is in root null, added an rstrip numerals button

TO DO:
Preview: generating a preview should not alter the selection

"""

#=============================================================

from win32com.client import constants as c
#from string import *

true = 1
false = 0
oRoot = Application.ActiveSceneRoot
xsi = Application
log = xsi.LogMessage

aAddParameter = ("Prefix","Prefix","Suffix","Suffix","After Char","After Char")
aRemoveParameter = ("Remove String","Remove String","Remove All Before","Remove All Before","Remove All After","Remove All After")

try:
    xsi.DeleteObj("Namer")
except Exception:
    log("Script property node not found. Proceeding...")

#oScriptNull = oRoot.AddNull("cmx_namer")
#xsi.HideAndUnselect(oScriptNull)
oPSet = oRoot.AddProperty("CustomProperty",false,"Namer")

#add parameters to the parameter set
oPSet.AddParameter3("sFind",c.siString)
oPSet.AddParameter3("sReplace",c.siString)
oPSet.AddParameter3("sAdd",c.siString)
oPSet.AddParameter3("sAddParameter",c.siString, "Prefix")
oPSet.AddParameter3("sAddPosition",c.siUInt2)
oPSet.AddParameter3("sAddCharacter",c.siString)
oPSet.AddParameter3("sRemove",c.siString)
oPSet.AddParameter3("sRemoveParameter",c.siString, "Remove String")
oPSet.AddParameter3("sRemovePosition",c.siUInt2)
oPSet.AddParameter3("sPreview",c.siString,"Preview the name change here.\n")
oPSet.AddParameter3("sCaseMethod",c.siString)
oPSet.AddParameter3("sNote01",c.siString,"If you leave Find String blank, Replace will Rename instead.")
oPSet.AddParameter3("sPadding",c.siInt2,3)

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
oItem = oLayout.AddButton("SelectChildren","Select Children")
oLayout.EndRow()

oLayout.EndGroup()
#replace group-----------------------------------------------------------
oLayout.AddGroup("Replace String", true)
oLayout.AddRow()
#oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
#oItem.SetAttribute(c.siUIWidthPercentage, 100)
oLayout.EndRow()
oLayout.AddRow()
#oItem = oLayout.AddButton("GenPreview_FR", "Generate Preview")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
oItem = oLayout.AddItem("sReplace","Replace With:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddButton("Replace", "Replace in Selected")
oLayout.EndRow()

oLayout.EndGroup()
#begin note 01-------------------------------------------------------------
oLayout.AddGroup("",0)
oLayout.AddRow()
oItem = oLayout.AddItem("sNote01", "Note: ", c.siControlStatic)
oLayout.EndRow()
oLayout.EndGroup()

#begin second tab===========================================================
oLayout.AddTab("Add and Remove")
#add group------------------------------------------------------------------
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
#oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oLayout.EndRow()
oLayout.AddRow()
#oItem = oLayout.AddButton("GenPreview_ADD", "Generate Preview")
oLayout.EndRow()
oLayout.EndGroup()

#remove group---------------------------------------------------------------
oLayout.AddGroup("Remove String")
oLayout.AddRow()
oItem = oLayout.AddItem("sRemove", "Remove String:", c.siControlString)
oLayout.EndRow()
oLayout.AddRow()
oItem = oLayout.AddItem("sRemoveParameter", "Remove Method:", c.siControlRadio)
oItem.UIItems = aRemoveParameter
oLayout.EndRow()

oLayout.AddRow()
oItem = oLayout.AddItem("sRemovePosition","Position:",c.siControlString)
oItem.SetAttribute(c.siUIWidthPercentage, 50)
oItem = oLayout.AddSpacer()
oLayout.EndRow()

oLayout.AddRow()
oItem = oLayout.AddButton("RemoveFromSelected", "Remove From Selected")
oItem = oLayout.AddButton("RemoveAll", "Remove From All")
oItem = oLayout.AddButton("RemoveNumb", "Remove #0-9")
oItem = oLayout.AddButton("RemoveRNumb", "Remove Trailing #")

oItem = oLayout.AddButton("RemoveChar", "Remove aA-zZ")
oLayout.EndRow()
oLayout.AddSpacer()
oLayout.AddRow()
#oItem = oLayout.AddItem("sPreview", "Preview Change:", c.siControlStatic)
oLayout.EndRow()
oLayout.AddRow()
#oItem = oLayout.AddButton("GenPreview_REM", "Generate Preview")
oLayout.EndRow()

oLayout.EndGroup()


#begin third tab===========================================================
oLayout.AddTab("Other")
oLayout.AddGroup("Flipmode")
oLayout.AddRow()
oItem = oLayout.AddButton("FlipName","Flip Selected")
oItem = oLayout.AddItem("sPadding","Number Padding:",c.siControlString)
oItem = oLayout.AddButton("NumbPadding", "Number Padding")
oLayout.EndRow()
oLayout.EndGroup()


#add logic to the property page
oLayout.Logic = """
from win32com.client import constants as c
from string import count, replace, split
xsi = Application
log = xsi.LogMessage
oProperty = "Namer"
#import re

#begin find and replace stuff===============================================

def FindInSel_OnClicked():
    oSelection = xsi.GetValue("Selectionlist")
    vFindString = xsi.GetValue(oProperty+".sFind")
    log("DEBUG: Finding objects whos name contains %s" % vFindString)
    for thing in oSelection:
        if count(thing.Name, vFindString) < 1:
            xsi.RemoveFromSelection(thing)

def FindAll_OnClicked():
    vFindString = xsi.GetValue(oProperty+".sFind")
    xsi.SelectAll()
    oSelection = xsi.GetValue("SelectionList")
    xsi.DeselectAll()
    for thing in oSelection:
        if count(thing.Name, vFindString) >= 1:
            xsi.AddToSelection(thing)

def SelectChildren_OnClicked():
    xsi.cxSelectChild()
         
def Replace_OnClicked():
    vFindString = xsi.GetValue(oProperty+".sFind")
    vReplaceString = xsi.GetValue(oProperty+".sReplace")
    oSelection = xsi.GetValue("SelectionList")
    if (vFindString != ""):
        for thing in oSelection:
            vNewName = replace(thing.Name,vFindString,vReplaceString)
            thing.Name = vNewName
    else:
        for thing in oSelection:
            thing.Name = vReplaceString

def GenPreview_FR_OnClicked():
    i = 0
    vFindString = xsi.GetValue(oProperty+".sFind")
    vReplaceString = xsi.GetValue(oProperty+".sReplace")
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        while (i == 0):
            if (vFindString != ""):
                vNewName = replace(thing.Name,vFindString,vReplaceString)
            else:
                vNewName = vReplaceString
            xsi.SetValue(oProperty+".sPreview", "Preview: " + vNewName + "\\n")
            log("DEBUG: Creating preview...%s" % vNewName)
            i += 1
           
#end find and replace stuff===================================================
#begin add and remove stuff===================================================

def AddToSelected_OnClicked():
    vAddString = xsi.GetValue(oProperty+".sAdd")
    vAddParameter = xsi.GetValue(oProperty+".sAddParameter")
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
        vAddChar = xsi.GetValue(oProperty+".sAddCharacter")
        vAddPos = xsi.GetValue(oProperty+".sAddPosition")
        if (vAddChar == ""):
            for thing in oSelection:
                vCount = len(thing.Name)
                vNewName = thing.Name[0:vAddPos] + vAddString + thing.Name[vAddPos:vCount]
                thing.Name = vNewName
        else:
            for thing in oSelection:
                i = 0
                vCount = (thing.Name).count(vAddChar)
                vAddCharLength = len(vAddChar)
                vLength = len(thing.Name)
                oldPrefLength = 0
                vNewPref = ""
                vNewSuff = thing.Name
                while (i < vAddPos) and (vAddPos <= vCount):
                    vPrefLength = (vNewSuff).find(vAddChar)
                    #log("DEBUG: " + str(vPrefLength))
                    vNewPref = vNewPref + vNewSuff[0:vPrefLength+vAddCharLength]
                    #log("DEBUG1: " + vNewPref)
                    vNewSuff = thing.Name[len(vNewPref):vLength]
                    #log("DEBUG2: " + vNewSuff)
                    i += 1
                thing.Name = vNewPref+vAddString+vNewSuff

def AddToAll_OnClicked():            
    vAddString = xsi.GetValue(oProperty+".sAdd")
    vAddParameter = xsi.GetValue(oProperty+".sAddParameter")
    xsi.SelectAll()
    #xsi.RemoveFromSelection("cmx_namer")
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
        vAddChar = xsi.GetValue(oProperty+".sAddCharacter")
        vAddPos = xsi.GetValue(oProperty+".sAddPosition")
        if (vAddChar == ""):
            for thing in oSelection:
                vCount = len(thing.Name)
                vNewName = thing.Name[0:vAddPos] + vAddString + thing.Name[vAddPos:vCount]
                thing.Name = vNewName
        else:
            for thing in oSelection:
                i = 0
                vCount = (thing.Name).count(vAddChar)
                vAddCharLength = len(vAddChar)
                vLength = len(thing.Name)
                oldPrefLength = 0
                vNewPref = ""
                vNewSuff = thing.Name
                while (i < vAddPos) and (vAddPos <= vCount):
                    vPrefLength = (vNewSuff).find(vAddChar)
                    #log("DEBUG: " + str(vPrefLength))
                    vNewPref = vNewPref + vNewSuff[0:vPrefLength+vAddCharLength]
                    #log("DEBUG1: " + vNewPref)
                    vNewSuff = thing.Name[len(vNewPref):vLength]
                    #log("DEBUG2: " + vNewSuff)
                    i += 1
                thing.Name = vNewPref+vAddString+vNewSuff

                
def RemoveFromSelected_OnClicked():
    vRemoveString = xsi.GetValue(oProperty+".sRemove")
    vRemoveParameter = xsi.GetValue(oProperty+".sRemoveParameter")
    vRemovePosition = xsi.GetValue(oProperty+".sRemovePosition")
    oSelection = xsi.GetValue("SelectionList")
    if (vRemoveParameter == "") or (vRemoveParameter == "Remove String"):
        for thing in oSelection:
            vNewNameList = (thing.Name).split(vRemoveString,2)
            #log("DEBUG1: " + str(vNewNameList))
            vNewName = str(vNewNameList[0]) + str(vNewNameList[1])
            #log("DEBUG2: " + str(vNewName))
            thing.Name = vNewName
    elif (vRemoveParameter == "Remove All Before"):
        if (vRemovePosition == 0):
            for thing in oSelection:
                vNewNameList = (thing.Name).split(vRemoveString,2)
                vNewName = (vRemoveString + str(vNewNameList[1]))
                thing.Name = vNewName
        else:
            for thing in oSelection:
                vNameLength = len(thing.Name)
                vNewName = (thing.Name)[vRemovePosition-1:vNameLength]
                thing.Name = vNewName
    elif (vRemoveParameter == "Remove All After"):
        if (vRemovePosition == 0):
            for thing in oSelection:
                vNewNameList = (thing.Name).split(vRemoveString,2)
                vNewName = (str(vNewNameList[0])+vRemoveString)
                thing.Name = vNewName
        else:
            for thing in oSelection:
                vNewName = (thing.Name)[0:vRemovePosition]
                thing.Name = vNewName

def RemoveAll_OnClicked():
	vRemoveString = xsi.GetValue(oProperty+".sRemove")
	xsi.SelectAll()
	#xsi.RemoveFromSelection("cmx_namer")
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

def GenPreview_ADD_OnClicked():
    vAddString = xsi.GetValue(oProperty+".sAdd")
    vAddParameter = xsi.GetValue(oProperty+".sAddParameter")
    oSelection = xsi.GetValue("SelectionList")
    #xsi.DeselectAll()
    if (vAddParameter == "") or (vAddParameter == "Prefix"):
        for thing in oSelection:
            vNewName = vAddString + thing.Name
            xsi.SetValue(oProperty+".sPreview", "Preview: " + vNewName + "\\n")
            
    elif (vAddParameter == "Suffix"):
        for thing in oSelection:
            vNewName = thing.Name + vAddString
            xsi.SetValue(oProperty+".sPreview", "Preview: " + vNewName + "\\n")
            
    elif (vAddParameter == "After Char"):
        vAddChar = xsi.GetValue(oProperty+".sAddCharacter")
        vAddPos = xsi.GetValue(oProperty+".sAddPosition")
        if (vAddChar == ""):
            for thing in oSelection:
                vCount = len(thing.Name)
                vNewName = thing.Name[0:vAddPos] + vAddString + thing.Name[vAddPos:vCount]
                xsi.SetValue(oProperty+".sPreview", "Preview: " + vNewName + "\\n")
        else:
            for thing in oSelection:
                i = 0
                vCount = (thing.Name).count(vAddChar)
                vAddCharLength = len(vAddChar)
                vLength = len(thing.Name)
                oldPrefLength = 0
                vNewPref = ""
                vNewSuff = thing.Name
                while (i < vAddPos) and (vAddPos <= vCount):
                    vPrefLength = (vNewSuff).find(vAddChar)
                    #log("DEBUG: " + str(vPrefLength))
                    vNewPref = vNewPref + vNewSuff[0:vPrefLength+vAddCharLength]
                    #log("DEBUG1: " + vNewPref)
                    vNewSuff = thing.Name[len(vNewPref):vLength]
                    #log("DEBUG2: " + vNewSuff)
                    i += 1
                xsi.SetValue(oProperty+".sPreview", "Preview: " + vNewPref+vAddString+vNewSuff)

def GenPreview_REM_OnClicked():
	vRemoveString = xsi.GetValue(oProperty+".sRemove")
	oSelection = xsi.GetValue("SelectionList")
	for thing in oSelection:
		vNewNameList = (thing.Name).split(vRemoveString,2)
		#log("DEBUG1: " + str(vNewNameList))
		vNewName = str(vNewNameList[0]) + str(vNewNameList[1])
		#log("DEBUG2: " + str(vNewName))
		xsi.SetValue(oProperty+".sPreview", vNewName)

def RemoveNumb_OnClicked():
    import re
    p = re.compile('[0-9]')
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        vNewName = p.sub("",thing.Name)
        thing.Name = vNewName

def RemoveRNumb_OnClicked():
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        vNewName = thing.Name.rstrip('0123456789')
        thing.Name = vNewName

def NumbPadding_OnClicked():
    oPadding = xsi.GetValue(oProperty+".sPadding")
    #log(str(oPadding))
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        oName = thing.Name
        oNameLength = len(thing.Name)
        oNewName = thing.Name.rstrip('0123456789')
        oNewNameLength = len(oNewName)
        oDiff = int(oNameLength - oNewNameLength)
        #log('oDiff: ' + str(oDiff))
        oNumerals = thing.Name[oNewNameLength:oNameLength]
        oNumerals = oNumerals.lstrip('0')
        #log('oNumerals: ' + str(oNumerals) + ' length: ' + str(len(oNumerals)))
        #log('(oDiff-len(oNumerals) : '+str(int(oDiff-len(oNumerals))))
        vNewName = (oNewName + ('0'*int(oPadding-len(oNumerals)) + oNumerals))
        #log(str(vNewName))
        thing.Name = vNewName

def RemoveChar_OnClicked():
    import re
    p = re.compile('[a-z]', re.IGNORECASE)
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        vNewName = p.sub("",thing.Name)
        thing.Name = vNewName

def FlipName_OnClicked():
    oSelection = xsi.GetValue("SelectionList")
    for thing in oSelection:
        vFirstChars = thing.Name[0:2]
        vLastChar = thing.Name[len(thing.Name)-1]
        log('DEBUG: vFirstChars '+ vFirstChars + ' and vLastChar ' + vLastChar)
        if (vFirstChars == 'r_') or (vFirstChars == 'R_'):
            if (vLastChar == '1'):
                vNewName = str('L_' + ((thing.Name).rstrip(vLastChar)).lstrip(vFirstChars))
                thing.Name = vNewName
        elif (vFirstChars == 'l_') or (vFirstChars == "L_"):
            if (vLastChar == '1'):
                vNewName = str('R_' + ((thing.Name).rstrip(vLastChar)).lstrip(vFirstChars))
                thing.Name = vNewName
                

"""
#bring up the custom ppg
xsi.InspectObj(oPSet)