''''Author: Stephen Wagner
''''Requested: Matt Kapfhammer
''''Version: 1.0
''''Cinemanix Productions
''''Release: 20071917
''''Language: VBScript

''''For XSI 5.11 on Windows 2k/XP
'=============================================================

'Abstract: Prompts the user to rename the selected objects with
'a prefix, name, and suffix based on the default accepted values
'from motion builder. 

'Script Use: Select an object or objects, run the script, and 
'select the desired options for prefix, name, and suffix. Then, hit
'the button and watch in horrer as your selected objects have their 
'identities stripped from them forever and replaced by a soulless
'mockery of the life they knew before.

'Version History: First Release
'=============================================================

dim oControlNull, oSelection, oPSet, oRoot, oPPGLayout, oItem
dim oParam1, oParam2, oParam3

aPrefixes = Array( "None", "", _
			"Left", "Left", _
			"Right", "Right")
			
			
aNames = Array( "FingerBase", "FingerBase", _
			"InHandThumb", "InHandThumb", _
			"InHandIndex", "InHandIndex", _
			"InHandMiddle", "InHandMiddle", _
			"InHandRing", "InHandRing", _
			"InHandPinky", "InHandPinky", _
			"InHandExtraFinger", "InHandExtraFinger", _
			"HandThumb", "HandThumb", _
			"HandIndex", "HandIndex", _
			"HandMiddle", "HandMiddle", _
			"HandRing", "HandRing", _
			"HandPinky", "HandPinky", _
			"HandExtraFinger", "HandExtraFinger", _
			"Shoulder", "Shoulder", _
			"Arm", "Arm", _
			"ArmRoll", "ArmRoll", _
			"ForeArm", "ForeArm", _
			"ForeArmRoll", "ForeArmRoll", _ 
			"Hand", "Hand", _
			"UpLeg", "UpLeg", _
			"UpLegRoll", "UpLegRoll", _
			"Leg", "Leg", _
			"LegRoll", "LegRoll", _
			"Foot", "Foot", _
			"ToeBase", "ToeBase", _
			"InFootThumb", "InFootThumb", _
			"InFootIndex", "InFootIndex", _
			"InFootMiddle", "InFootMiddle", _
			"InFootRing", "InFootRing", _
			"InFootPinky", "InFootPinky", _
			"InFootExtraFinger", "InFootExtraFinger", _
			"FootThumb", "FootThumb", _
			"FootIndex", "FootIndex", _
			"FootMiddle", "FootMiddle", _
			"FootRing", "FootRing", _
			"FootPinky", "FootPinky", _
			"FootExtraFinger", "FootExtraFinger", _
			"Props", "Props",_
			"Reference", "Reference", _
			"Hips", "Hips", _
			"Spine", "Spine", _
			"Neck", "Neck", _
			"Head", "Head" )
			
			'AUGHHGHGG


set oRoot = ActiveSceneRoot
on error resume next
DeleteObj "MB_Renamer_Script"
set oControlNull = oRoot.AddNull("MB Renamer Script")
set oPSet = oControlNull.AddProperty("CustomProperty",false,"Prompt")


oPset.AddParameter3 "Prefix", siString
oPset.AddParameter3 "Nameo", siString 
oPset.AddParameter3 "Suffix", siString

set oPPGLayout = oPset.PPGLayout


oPPGLayout.AddGroup "Rename", true
oPPGLayout.AddRow

oPPGLayout.AddGroup "",false,25
set oItem = oPPGLayout.AddEnumControl("Prefix", aPrefixes, "Prefix" ,siControlCombo)
oPPGLayout.EndGroup

oPPGLayout.AddGroup "",false,50
set oItem = oPPGLayout.AddEnumControl("Nameo", aNames, "Name", siControlCombo)
oPPGLayout.EndGroup

oPPGLayout.AddGroup "",false,25
set oItem = oPPGLayout.AddItem("Suffix", "Suffix", siControlNumber)
oItem.SetAttribute "noslider", true
oPPGLayout.EndGroup
oPPGLayout.Endrow
set oItem = oPPGLayout.AddButton("Rename")
oPPGLayout.EndGroup

oPPGLayout.Logic = "sub Rename_OnClicked" & vbCrlf & "dim oSelection" & vbCrlf & "set oSelection = Selection" & vbCrlf &"	p = Prefix" & vbCrlf & "	n = Nameo" & vbCrlf & "	s = Suffix" & vbCrlf & "   for each thing in selection" & vbCrlf & "		thing.name = p&n&s"&vbCrlf&"	next"&vbCrlf&"end sub"




inspectObj oPSet ''Note: when inspecting your control object, you point inspectObj at the custom property set, not the object itself