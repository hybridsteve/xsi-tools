#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Version: 1.1
#Cinemanix Productions
#Release: 20071104
#Langauge: Python

#For XSI 5.11 on Windows 2k/XP
#==========================================================

#Abstract: Script selects all children of an object, or
#recursively selects all children of children of...a
#selected object. This differs from "branch" selection
#mode.

#LEFT MOUSE BUTTON: Select immediate children of picked object.
#CTRL + LEFT MOUSE BUTTON: Select all children of picked object.

#Script Use: Running the script will initiate a picking session,
#wherein the picked object and it's children (depending on the
#control key) will become the selected objects.

#Version History: Transcribed to Python. Second Release, adds
#requested functionality.
#==========================================================

xsi = Application

def TrueChildSelect( rflag,oSpace ):
    if (rflag == 1):
            for thing in xsi.Selection:
                try:
                    xsi.AddToSelection(thing.Children)
                except Exception:
                    xsi.LogMessage("")
    else:
        for thing in oSpace:
        	xsi.AddToSelection(thing.Children)

#rPicked, rButton, rMod
rarPicked = xsi.PickObject("Select Immediate Children","[CTRL + LMB] Select All Children")
xsi.DeselectAll()
xsi.SelectObj(rarPicked.Value("PickedElement"))
#xsi.LogMessage(rarPicked(0))
oSpace = xsi.GetValue("SelectionList")

if rarPicked.Value("ButtonPressed") == 1:
    if rarPicked.Value("ModifierPressed") == 2:
        xsi.LogMessage("debug SELECT ALL CHILDREN-CTRL")
        TrueChildSelect( 1,oSpace )
    else:
        xsi.LogMessage("debug SELECT IMMEDIATE CHILDREN")
        TrueChildSelect( 0,oSpace )
        