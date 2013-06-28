#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Major Version: 00
#Minor Version: 03
#Cinemanix Productions
#Release: -1
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#AVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAV

"""Abstract: Script to automate much of the process that occurs after
setting up a model with the PointCache script."""

# Freeze modeling stack.
# Delete all operators except KP_PointCache Scripted Op
# Delete the "ShapeWeights" custom parameter set.
# Delete env cls, shp cls, sym cls's with these strings in them: "SHP_", "EnvelopWeightCls", "SymmetryMapCls".

"""Script Use: Script runs on selected objects, performing the
necessary operations on them."""


#AVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAVAV
true = 1
false = 0
xsi = Application
log = xsi.LogMessage
oRoot = xsi.ActiveSceneRoot

oSelection = xsi.GetValue("SelectionList")
xsi.DeselectAll()
for thing in oSelection:
    xsi.FreezeObj()
    xsi.DeleteObj(str(thing)+".ShapeWeights")
    xsi.SelectObj(str(thing)+".polymsh.*op")
    oOpSelection = xsi.GetValue("SelectionList")
    for op in oOpSelection:
        xsi.FreezeObj()
    try:
        xsi.AddToSelection(str(thing)+".polymsh.cls.*SHP_*")
    except Exception:
        log("doi. no SHP_ cluster")
    try:
        xsi.AddToSelection(str(thing)+".polymsh.cls.*EnvelopWeightCls*")
    except Exception:
        log("doi. no EnvelopWeightCls")
    try:
        xsi.AddToSelection(str(thing)+".polymsh.cls.*SymmetryMapCls*")
    except Exception:
        log("doi. no SymmetryMapCls")
    oClsSelection = xsi.GetValue("SelectionList")
    for cls in oClsSelection:
        xsi.DeleteObj()
    

