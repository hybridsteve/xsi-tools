#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Version: 0.5
#Cinemanix Productions
#Release: 20071922
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================

#Abstract: Script searches for incongruent normals on a selected
#object's geometry and attempts to correct them, based on a simple
#comparison to the average normals of the surrounding geometry.

#Script Use: Select the 3d Geometry object that you want to run the 
#script on. If multiple objects are selected, they will probably all
#get treated. Once you have the desired object selected, run the script.
#You will get a progress bar indicating the script's current progress. 

#Version History: Currently in beta testing, now with progress bar. To do:
#PPG with the ability to change the threshold, sample poly range
#=============================================================

from win32com.client import constants as c
import sys, types
from operator import div, abs

oNormalXList = 0
oNormalYList = 0
oNormalZList = 0
XYZListCount=0
NormalXRef = 0
NormalYRef = 0
NormalZRef = 0
testcontinue = 0

#Set the threshold that determines what "inverted" means, 1.6 is sweet spot for higher poly
#Value will probably have to be set much higher for much lower poly stuff, may not work at all
oNormalReverseThreshold = 1.6
#Set the amount of polys around the target poly to average,
#A value of 1 will be faster but will have problems with groups of bad polys together
#A value of 2 will be much slower, will be able to solve clumps of bad polys together
oTargetGrowAmount = 1


#Get the selected object(s)
oRoot = Application.ActiveSceneRoot
oSelectedObj = Application.GetValue("SelectionList")
Application.LogMessage(oSelectedObj.Type)

#Test the selected object(s) to make sure they are compatable with the rest of the script
if oSelectedObj.count > 0:
	for thing in oSelectedObj:
		if thing.Type == "polymsh":
			Application.LogMessage("%s" % thing.Type)
			testcontinue = 1
			Application.LogMessage("Selection %s is a workable mesh; continuing..." % thing)
			oWorkingObj = thing
			oWorkingMesh = thing.ActivePrimitive.Geometry
			#Create a progress bar and its associated attributes
			oProgressBar = XSIUIToolkit.ProgressBar
			oProgressBar.Maximum = 100
			oProgressBar.Step = 1
			oProgressBar.Caption = "Checking And Correcting Normals"
			oProgressBar.CancelEnabled = 0
			oProgressBar.Visible = 1
		else:
			testcontinue = 0
			Application.LogMessage("Selection is not an X3DObject, script will not continue...")
else:
	Application.LogMessage("No object selected. Script will not continue...")
Application.DeselectAll()

def testAverageNormals(poly):
#	These logs are commented out because they slow down the script considerably. They are for debugging purposes.
#	Application.LogMessage("Working from polygon index %s" % poly.index)
	oAdjacentPolys = poly.GrowNeighborPolygons(oTargetGrowAmount)
	XYZListCount = 0
	oNormalXList = 0
	oNormalYList = 0
	oNormalZList = 0
	for polys in oAdjacentPolys:
		oPolysNode = polys.Nodes(0)
		oPolysNormal = oPolysNode.Normal
		oNormalXList+=(oPolysNode.Normal.X)
		oNormalYList+=(oPolysNode.Normal.Y)
		oNormalZList+=(oPolysNode.Normal.Z)
		XYZListCount+=1
#		Application.LogMessage("%(what)s %(numb)s is a polygon adjacent to the current one with normal %(nx)s, %(ny)s, %(nz)s" % {"numb":polys.index,"what":polys.Type,"nx":oPolysNormal.X,"ny":oPolysNormal.Y,"nz":oPolysNormal.Z})
	oAverageNormalX = div(oNormalXList,XYZListCount)
	oAverageNormalY = div(oNormalYList,XYZListCount)
	oAverageNormalZ = div(oNormalZList,XYZListCount)
	NormalXRef = poly.Nodes(0).Normal.X
	NormalYRef = poly.Nodes(0).Normal.Y
	NormalZRef = poly.Nodes(0).Normal.Z
	deltax = abs(oAverageNormalX-NormalXRef)
	deltay = abs(oAverageNormalY-NormalYRef)
	deltaz = abs(oAverageNormalZ-NormalZRef)
#	Application.LogMessage("Total Normal delta for poly index %(polyindex)s is %(deltasum)s" % {"polyindex":poly.index,"deltasum":(deltax+deltay+deltaz)})
	if ((deltax+deltay+deltaz)>oNormalReverseThreshold):
		return 1
	else:
		return 0

# If the check at the beginning determines that selected object is workable, begin testing polygons..
if testcontinue == 1:
	#Get the facets (polys) list from the geometry...
	oPolygonFaces = oWorkingMesh.Facets
	#Get the number of things in the list of facets...
	oPBarLength = oPolygonFaces.Count
	#Set up the increment code for the progress bar, so that it scales its percentage based on total number of polys
	oPBarIncThr = div(oPBarLength,100)
	oPBarIncThrAmount = oPBarIncThr
	oPBarIncrem = 0
#	Application.LogMessage("Well, cool...you have %s polygons in your mesh." % oPolygonFaces.count)
	for poly in oPolygonFaces:
		#This stuff controls how the progress bar increments.
		oPBarIncrem += 1
		while (oPBarIncrem > oPBarIncThr):
			oProgressBar.Increment()
			oPBarIncThr += oPBarIncThrAmount
		#If the function that tests the normals of a poly against the average normals of the area returns a 1, invert that poly!
		if testAverageNormals(poly):
			polystring = ("%(objname)s.poly[%(polyindex)s]" % {"objname":oWorkingObj,"polyindex": poly.index})
			Application.ApplyTopoOp("InvertPolygon",polystring)
			Application.LogMessage("Polygon normal is above threshold, inverting normal.")

#Once we're done with the faces on the object (reached the end of the code), if the script decided it was supposed to run, clean up
if testcontinue == 1:
	#Turn off progress bar.
	oProgressBar.Visible = 0
	Application.LogMessage("Script completed.")	