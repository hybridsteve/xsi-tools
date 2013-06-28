#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Major Version: 01
#Minor Version: 05
#Cinemanix Productions
#Release: 20071914
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================
'''
Abstract: Script uses selected bones to create nulls that are
matched to the transforms of those bones and appear as boxes.

Script Use: This script houses some functions related to cx
commands, such as EnvNulls, and MB Nulls from Guide. Those commands
will create a hierarchy of nulls based on the position of selected
elements or elements that are automatically found in the scene in the
event that no elements are selected. These nulls can then be enveloped to.

NOTE: If you have an "ENV_Root" in the scene already, make sure
you remove or rename it, as it will interfere with the script.

Version History: 0105: added new functions for new mb workflow test
				0104: some major functionality changes
				0103: Added code to parent each null to appropriate bone
				First release. Converted to Python
'''
#=============================================================
#GLOBALS
#import constants from windows, declare normal variables and shortcuts
from win32com.client import constants as c
import win32com.client
from string import *

true = 1
false = 0
oRoot = Application.ActiveSceneRoot
xsi = Application
log = xsi.LogMessage

#=============================================================
#FUNCTIONS

def cxEnvNulls( oColl, oMode ):
	log("Number of items selected is " + str(oColl.Count))
	if (oColl.Count == 0):
		if (oMode != 'motionbuilder2'):
			log('cxEnvNulls[arg0] -- No objects selected',2)
			return(false)
		else:
			log('cxEnvNulls[arg0] -- No objects selected, automating...')
			try:
				xsi.SelectAll()
				oSelection = xsi.GetValue('SelectionList')
				xsi.DeselectAll()
				for thing in oSelection:
					if (thing.name.count('_JNT') > 0):
						oColl.Add(thing)
			except Exception:
				log('cxEnvNulls[arg0] -- No valid objects in scene',2)
				return(false)
	#filter all but these types from oColl
	oColl = xsi.SIFilter(oColl,'curve,polygonmesh,null,joint,implicit,bone')
	#tests validity of oColl after filtering
	try:
		oVar = oColl.Count
	except Exception:
		log('cxEnvNulls[arg0] -- Collection contains no valid objects',2)
		return(false)
	nullColl = win32com.client.Dispatch('XSI.Collection')
	if (oMode == 'xsi'):
		oNewRootNull = xsi.ActiveSceneRoot.AddNull("Env_Root")
	if (oMode == 'motionbuilder2'):
		oNewRootModel = xsi.ActiveSceneRoot.AddModel(nullColl, "CharacterName")
		for thing in oColl:
			#try:
			oNull = oCloneNullFromBone2( thing )
			nullColl.Add(oNull)
			if (oNull.name.count('Left') > 0):
				oName = str('Right' + str(oNull.name[4:(len(oNull.name))]))
				log(oName)
				oSymNull = xsi.DuplicateSymmetry(oNull,0,1,1,0,0)
				oSymNull[0].name = oName
				nullColl.Add(oSymNull[0])
			#except Exception:
				#log('cxEnvNulls[arg0] -- Thing in collection has no _JNT suffix',2)
		for thing in nullColl:
			xsi.ParentObj(oNewRootModel,thing)
	else:
		for thing in oColl:
			nullColl.Add(oCloneNullFromBone( thing, oMode ))
	return(nullColl)

def oCloneNullFromBone( oInputBone, oMode ):
	oNull = xsi.ActiveSceneRoot.AddNull(oInputBone.Name + "_ENV")
	xsi.MatchTransform(oNull, oInputBone, c.siSRT)
	log("Working from " + oInputBone.name)
	log("Created null " + oNull.name)
	xsi.SetValue( oNull.name + ".null.primary_icon", 0)
	xsi.SetValue( oNull.name + ".null.shadow_icon", 4)
	if (oMode == 'motionbuilder'):
		xsi.ParentObj(oInputBone, oNull)
	else:
		xsi.ParentObj("Env_Root", oNull)
		xsi.ApplyCns("Pose", oNull, oInputBone)
	return(oNull)

def oCloneNullFromBone2( oInputBone ):
	if (oInputBone.name.count('_JNT') > 0):
		oNull = xsi.ActiveSceneRoot.AddNull(oInputBone.name.replace('_JNT',''))
		xsi.MatchTransform(oNull, oInputBone, c.siSRT)
		log("Working from " + oInputBone.name)
		log("Created null " + oNull.name)
		xsi.SetValue( oNull.name + ".null.primary_icon", 0)
		xsi.SetValue( oNull.name + ".null.shadow_icon", 4)
		return(oNull)



#xsi.DeselectAll()
#PseudoCode (outdated)
#==============================================================
'''
create lists

set list oRigItems to the current selection
count the number of things in oRigItems
log a message of the number of things

create a new null under the root called "ENV_Root"


for each thing in oRigItems
	run the function oCloneNullFromBone
next

Deselect all objects


Define function oCloneNullFromBone( first argument )
	if the object sent to the function is a bone then
		add a new null underneath "ENV_Root" and set oNull to that null
		match the transforms of oNull to the bone that was sent to the function
		log a message about the bone
		log a message about the new null
		set the null's primary display to "none"
		set the null's shadow display to "box"
		parent the null to the bone
	else
	end if
end the function'''