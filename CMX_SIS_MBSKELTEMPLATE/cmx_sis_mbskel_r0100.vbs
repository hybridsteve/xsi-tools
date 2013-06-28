''''Author: Chrystia Siolkowsky
''''Release 1.0
''''Cinemanix Productions
''''07.04.04

''''Release Notes:
'Your rig is completely automated. 
'All the user input is gathered in the previous script, so this one immediately begins building a skeleton off the position of the nulls and then deletes the ones no longer needed for any further automation.
'After all the unnecessary objects are deleted, the script continues to build the FBX heirarchy with a series of nulls for the Reference, COG etc. and parents the bone chains accordingly.
'The arms, legs, hands and feet are duplicated.
'If your rig requires toes, they are created last.

'There is only one glitch: 
'If you are using this rig for M0c@p, after you export to .fbx (to bring into MotionBuilder), delete the original in XSI and re-import the .fbx, and your animation will come in fine.
'The .fbx is ready to be imported into MotionBuilder, and matches the default character definitions so it should auto-characterize.

''''declare variables
'---------------------------------------------------------------------
dim resultSpine, nullName, boneName, nullLast

''''retrieves number of spine bones from user input in null script
'-------------------------------------------------------------------------
resultSpine = GetValue("spineNum.null.size")

''''for purposes of make pretty button, WIP
'---------------------------------------------------
if resultSpine = 1 Then
	Create2DSkeleton GetValue("HipsNull.kine.local.posx"), GetValue("HipsNull.kine.local.posy"), GetValue("HipsNull.kine.local.posz"), GetValue("SpineEffectorNull.kine.local.posx"), GetValue("SpineEffectorNull.kine.local.posy"), GetValue("SpineEffectorNull.kine.local.posz"), 0, 0, 1, 4
else

''''create spine
'-----------------------------
Create2DSkeleton GetValue("HipsNull.kine.local.posx"), GetValue("HipsNull.kine.local.posy"), GetValue("HipsNull.kine.local.posz"), GetValue("SpineNull.kine.local.posx"), GetValue("SpineNull.kine.local.posy"), GetValue("SpineNull.kine.local.posz"), 0, 0, 1, 4

''''create a group for auto-controller button called "Make pretty", WIP
'--------------------------------------------------------------------------------
SelectObj "HipsNull", , True
CreateGroup
SetValue "Group.Name", "For_MakePretty"

''''builds a spine from the second spine null to second-last spine null
'----------------------------------------------------------------------------
for i = 1 to (resultSpine-2)
	boneName = "Spine" & (i)
	nullName = GetValue("SpineNull"&i)
	LogMessage nullName
	AppendBone "eff", GetValue(nullName&".kine.local.posx"), GetValue(nullName&".kine.local.posy"), GetValue(nullName&".kine.local.posz")
	SetValue nullName & ".visibility.viewvis", False
	SetValue "bone.bone1.Name", boneName
	CopyPaste nullName, , "For_MakePretty", 1
next 

''''for purposes of make pretty
'----------------------------------------------------
nullLast = "spineNull" & i
CopyPaste "SpineEffectorNull", , "For_MakePretty", 1
CopyPaste "spineNull", , "For_MakePretty", 1
SetValue "SpineEffectorNull.visibility.viewvis", False
SetValue "spineNull.visibility.viewvis", False
SetValue "HipsNull.visibility.viewvis", False

''''finishes spine chain
'-----------------------------------------------------------
AppendBone "eff", GetValue("SpineEffectorNull.kine.local.posx"), GetValue("SpineEffectorNull.kine.local.posy"), GetValue("SpineEffectorNull.kine.local.posz")

''''rename spine chain components
'-------------------------------------------------------------
SetValue boneName & ".bone1.Name", "Spine" & (i-1)
SetValue "root.Name,root.bone.Name,root.eff.Name", Array("Hips", "Spine", "SpineEffector")

end if

''''create neck and head
'-------------------------------------------------------
Create2DSkeleton GetValue("SpineEffectorNull.kine.local.posx"), GetValue("SpineEffectorNull.kine.local.posy"), GetValue("SpineEffectorNull.kine.local.posz"), GetValue("Neck.kine.local.posx"), GetValue("Neck.kine.local.posy"), GetValue("Neck.kine.local.posz"), 0, 0, 1, 4
SetValue "Neck.Name,root.Name,root.bone.Name,root.eff.Name", Array("NeckNull", "NeckRoot", "Neck", "NeckEffector")

Create2DSkeleton GetValue("NeckNull.kine.local.posx"), GetValue("NeckNull.kine.local.posy"), GetValue("NeckNull.kine.local.posz"), GetValue("HeadEffector.kine.local.posx"), GetValue("HeadEffector.kine.local.posy"), GetValue("HeadEffector.kine.local.posz"), 0, 0, 1, 4
SetValue "root.Name,root.bone.Name,root.eff.Name", Array("HeadRoot", "Head", "HeadEffector")

DeleteObj "NeckNull,HeadEffector"

''''create jaw
'--------------------------------------------------------------
Create2DSkeleton GetValue("LowJaw.kine.local.posx"), GetValue("LowJaw.kine.local.posy"), GetValue("LowJaw.kine.local.posz"), GetValue("JawEff.kine.local.posx"), GetValue("JawEff.kine.local.posy"), GetValue("JawEff.kine.local.posz"), 0, 0, 1, 4

DeleteObj "LowJaw,JawEff"

SetValue "root.Name,root.bone.Name,root.eff.Name", Array("LowJaw", "JawBone", "JawEff")

''''create left shoulder
'------------------------------------------------------------
Create2DSkeleton GetValue("LeftShoulderRoot.kine.local.posx"), GetValue("LeftShoulderRoot.kine.local.posy"), GetValue("LeftShoulderRoot.kine.local.posz"), GetValue("LeftShoulderEffector.kine.local.posx"), GetValue("LeftShoulderEffector.kine.local.posy"), GetValue("LeftShoulderEffector.kine.local.posz"), 0, 0, 1, 4

DeleteObj "LeftShoulderRoot"

SetValue "LeftShoulderEffector.Name,root.Name,root.bone.Name,root.eff.Name", Array("LeftShoulderEffectorNull", "LeftShoulderRoot", "LeftShoulder", "LeftShoulderEffector")

''''create left arm
'--------------------------------------------------------------
Create2DSkeleton GetValue("LeftShoulderEffectorNull.kine.local.posx"), GetValue("LeftShoulderEffectorNull.kine.local.posy"), GetValue("LeftShoulderEffectorNull.kine.local.posz"), GetValue("LeftArm.kine.local.posx"), GetValue("LeftArm.kine.local.posy"), GetValue("LeftArm.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftArmEffector.kine.local.posx"), GetValue("LeftArmEffector.kine.local.posy"), GetValue("LeftArmEffector.kine.local.posz")

DeleteObj "LeftShoulderEffectorNull,LeftArm"

SetValue "LeftArmEffector.Name,root.Name,root.bone.Name,bone.bone1.Name,root.eff.Name", Array("LeftArmEffectorNull", "LeftArmRoot", "LeftArm", "LeftForearm", "LeftArmEffector")

''''create left hand
'----------------------------------------------------------------
Create2DSkeleton GetValue("LeftArmEffectorNull.kine.local.posx"), GetValue("LeftArmEffectorNull.kine.local.posy"), GetValue("LeftArmEffectorNull.kine.local.posz"), GetValue("LeftHandEffector.kine.local.posx"), GetValue("LeftHandEffector.kine.local.posy"), GetValue("LeftHandEffector.kine.local.posz"), 0, 0, 1, 4

DeleteObj "LeftArmEffectorNull,LeftHandEffector"

SetValue "root.Name,root.bone.Name,root.eff.Name,root.eff.size", Array("LeftHandRoot", "LeftHand", "LeftHandEffector", 0.25)

''''create left thumb
'-------------------------------------------------------------
Create2DSkeleton GetValue("LeftThumbRoot.kine.local.posx"), GetValue("LeftThumbRoot.kine.local.posy"), GetValue("LeftThumbRoot.kine.local.posz"), GetValue("LeftHandThumb1.kine.local.posx"), GetValue("LeftHandThumb1.kine.local.posy"), GetValue("LeftHandThumb1.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftHandThumb2.kine.local.posx"), GetValue("LeftHandThumb2.kine.local.posy"), GetValue("LeftHandThumb2.kine.local.posz")
AppendBone "eff", GetValue("LeftThumbEffector.kine.local.posx"), GetValue("LeftThumbEffector.kine.local.posy"), GetValue("LeftThumbEffector.kine.local.posz")

DeleteObj "LeftThumbRoot,LeftHandThumb1,LeftHandThumb2,LeftThumbEffector"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name,root.size,root.bone.size,bone.bone1.size,bone1.bone2.size,root.eff.size", Array("LeftThumbRoot", "LeftHandThumb1", "LeftHandThumb2", "LeftHandThumb3", "LeftThumbEffector", 0.25, 0.25, 0.25, 0.25, 0.25)

''''create left index
'------------------------------------------------------------
Create2DSkeleton GetValue("LeftIndexRoot.kine.local.posx"), GetValue("LeftIndexRoot.kine.local.posy"), GetValue("LeftIndexRoot.kine.local.posz"), GetValue("LeftHandIndex1.kine.local.posx"), GetValue("LeftHandIndex1.kine.local.posy"), GetValue("LeftHandIndex1.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftHandIndex2.kine.local.posx"), GetValue("LeftHandIndex2.kine.local.posy"), GetValue("LeftHandIndex2.kine.local.posz")
AppendBone "eff", GetValue("LeftIndexEffector.kine.local.posx"), GetValue("LeftIndexEffector.kine.local.posy"), GetValue("LeftIndexEffector.kine.local.posz")

DeleteObj "LeftIndexRoot,LeftHandIndex1,LeftHandIndex2,LeftIndexEffector"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name,root.size,root.bone.size,bone.bone1.size,bone1.bone2.size,root.eff.size", Array("LeftIndexRoot", "LeftHandIndex1", "LeftHandIndex2", "LeftHandIndex3", "LeftIndexEffector", 0.25, 0.25, 0.25, 0.25, 0.25)

''''create left middle
'------------------------------------------------------------
Create2DSkeleton GetValue("LeftMiddleRoot.kine.local.posx"), GetValue("LeftMiddleRoot.kine.local.posy"), GetValue("LeftMiddleRoot.kine.local.posz"), GetValue("LeftHandMiddle1.kine.local.posx"), GetValue("LeftHandMiddle1.kine.local.posy"), GetValue("LeftHandMiddle1.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftHandMiddle2.kine.local.posx"), GetValue("LeftHandMiddle2.kine.local.posy"), GetValue("LeftHandMiddle2.kine.local.posz")
AppendBone "eff", GetValue("LeftMiddleEffector.kine.local.posx"), GetValue("LeftMiddleEffector.kine.local.posy"), GetValue("LeftMiddleEffector.kine.local.posz")

DeleteObj "LeftMiddleRoot,LeftHandMiddle1,LeftHandMiddle2,LeftMiddleEffector"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name,root.size,root.bone.size,bone.bone1.size,bone1.bone2.size,root.eff.size", Array("LeftMiddleRoot", "LeftHandMiddle1", "LeftHandMiddle2", "LeftHandMiddle3", "LeftMiddleEffector", 0.25, 0.25, 0.25, 0.25, 0.25)

''''create left ring
'-----------------------------------------------------------
Create2DSkeleton GetValue("LeftRingRoot.kine.local.posx"), GetValue("LeftRingRoot.kine.local.posy"), GetValue("LeftRingRoot.kine.local.posz"), GetValue("LeftHandRing1.kine.local.posx"), GetValue("LeftHandRing1.kine.local.posy"), GetValue("LeftHandRing1.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftHandRing2.kine.local.posx"), GetValue("LeftHandRing2.kine.local.posy"), GetValue("LeftHandRing2.kine.local.posz")
AppendBone "eff", GetValue("LeftRingEffector.kine.local.posx"), GetValue("LeftRingEffector.kine.local.posy"), GetValue("LeftRingEffector.kine.local.posz")

DeleteObj "LeftRingRoot,LeftHandRing1,LeftHandRing2,LeftRingEffector"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name,root.size,root.bone.size,bone.bone1.size,bone1.bone2.size,root.eff.size", Array("LeftRingRoot", "LeftHandRing1", "LeftHandRing2", "LeftHandRing3", "LeftRingEffector", 0.25, 0.25, 0.25, 0.25, 0.25)

''''create left pinky
'--------------------------------------------------------------
Create2DSkeleton GetValue("LeftPinkyRoot.kine.local.posx"), GetValue("LeftPinkyRoot.kine.local.posy"), GetValue("LeftPinkyRoot.kine.local.posz"), GetValue("LeftHandPinky1.kine.local.posx"), GetValue("LeftHandPinky1.kine.local.posy"), GetValue("LeftHandPinky1.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftHandPinky2.kine.local.posx"), GetValue("LeftHandPinky2.kine.local.posy"), GetValue("LeftHandPinky2.kine.local.posz")
AppendBone "eff", GetValue("LeftPinkyEffector.kine.local.posx"), GetValue("LeftPinkyEffector.kine.local.posy"), GetValue("LeftPinkyEffector.kine.local.posz")

DeleteObj "LeftPinkyRoot,LeftHandPinky1,LeftHandPinky2,LeftPinkyEffector"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name,root.size,root.bone.size,bone.bone1.size,bone1.bone2.size,root.eff.size", Array("LeftPinkyRoot", "LeftHandPinky1", "LeftHandPinky2", "LeftHandPinky3", "LeftPinkyEffector", 0.25, 0.25, 0.25, 0.25, 0.25)

''''create junk
'--------------------------------------------------------------
Create2DSkeleton GetValue("CrotchRoot.kine.local.posx"), GetValue("CrotchRoot.kine.local.posy"), GetValue("CrotchRoot.kine.local.posz"), GetValue("JunkEff.kine.local.posx"), GetValue("JunkEff.kine.local.posy"), GetValue("JunkEff.kine.local.posz"), 0, 0, 1, 4

DeleteObj "CrotchRoot,JunkEff"

SetValue "root.Name,root.bone.Name,root.eff.Name", Array("CrotchRoot", "DingDong", "JunkEffector")

''''create left leg
'--------------------------------------------------------------
Create2DSkeleton GetValue("LeftUpLegRoot.kine.local.posx"), GetValue("LeftUpLegRoot.kine.local.posy"), GetValue("LeftUpLegRoot.kine.local.posz"), GetValue("LeftUpLeg.kine.local.posx"), GetValue("LeftUpLeg.kine.local.posy"), GetValue("LeftUpLeg.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftLegEffector.kine.local.posx"), GetValue("LeftLegEffector.kine.local.posy"), GetValue("LeftLegEffector.kine.local.posz")

DeleteObj "LeftUpLegRoot,LeftUpLeg"

SetValue "LeftLegEffector.Name,root.Name,root.bone.Name,bone.bone1.Name,root.eff.Name", Array("LeftLegEffectorNull", "LeftUpLegRoot", "LeftUpLeg", "LeftLeg", "LeftLegEffector")

''''create left foot
'--------------------------------------------------------------
Create2DSkeleton GetValue("LeftLegEffectorNull.kine.local.posx"), GetValue("LeftLegEffectorNull.kine.local.posy"), GetValue("LeftLegEffectorNull.kine.local.posz"), GetValue("LeftFoot.kine.local.posx"), GetValue("LeftFoot.kine.local.posy"), GetValue("LeftFoot.kine.local.posz"), 0, 0, 1, 4
AppendBone "eff", GetValue("LeftToeEffector.kine.local.posx"), GetValue("LeftToeEffector.kine.local.posy"), GetValue("LeftToeEffector.kine.local.posz")

DeleteObj "LeftFootRoot,LeftFoot,LeftToeEffector,LeftLegEffectorNull"

SetValue "root.Name,root.bone.Name,bone.bone1.Name,root.eff.Name", Array("LeftFootRoot", "LeftFoot", "LeftToeBase", "LeftToeEffector")

'''set heirarchy - parent
'------------------------------------------------------------------
ParentObj "B:SpineEffector", "NeckRoot"
ParentObj "B:Neck", "HeadRoot"
ParentObj "B:Head", "LowJaw"
ParentObj "B:LeftShoulderEffector", "LeftArmRoot"
ParentObj "B:LeftArmEffector", "LeftHandRoot"
ParentObj "B:LeftHandEffector", "LeftIndexRoot,LeftMiddleRoot,LeftPinkyRoot,LeftRingRoot,LeftThumbRoot"
ParentObj "B:LeftLegEffector", "LeftFootRoot"
ParentObj "B:Hips", "CrotchRoot"

''''sets neutral pose - zeroes out root and effector SRT
SetAndToggleSelection "Hips, SpineEffector, NeckRoot, HeadEffector, LeftShoulderRoot, LeftShoulderEffector, LeftArmRoot, LeftArmEffector, LeftHandRoot, LeftHandEffector, LeftThumbRoot, LeftThumbEffector, LeftIndexRoot, LeftIndexEffector, LeftMiddleRoot, LeftMiddleEffector, LeftRingRoot, LeftRingEffector, LeftPinkyRoot, LeftPinkyEffector, LeftUpLegRoot, LeftLegEffector, LeftFootRoot, LeftToeEffector, LowJaw, JawEff, CrotchRoot, JunkEffector"
SetNeutralPose , siSRT

'''retrieves global variable from previous script - initiated if toes are present
'---------------------------------------------------------------------------------------
if GetValue("Toes.size") = 2 Then

	'''' create, rename, resize, parent left toe thumb
	'------------------------------------------------------
	Create2DSkeleton GetValue("LeftFootThumbRoot.kine.local.posx"), GetValue("LeftFootThumbRoot.kine.local.posy"), GetValue("LeftFootThumbRoot.kine.local.posz"), GetValue("LeftFootThumb1.kine.local.posx"), GetValue("LeftFootThumb1.kine.local.posy"), GetValue("LeftFootThumb1.kine.local.posz"), 0, 0, 0, 4
	AppendBone "eff", GetValue("LeftFootThumbEff.kine.local.posx"), GetValue("LeftFootThumbEff.kine.local.posy"), GetValue("LeftFootThumbEff.kine.local.posz")

	DeleteObj "LeftFootThumbRoot,LeftFootThumb1,LeftFootThumbEff"
	SetValue "root.Name,root.bone.Name,bone.bone1.Name,root.eff.Name", Array("LeftFootThumbRoot", "LeftFootThumb1", "LeftFootThumb2", "LeftFootThumbEff")

	'''' create, rename, resize, parent left toe index
	'-----------------------------------------------------
	Create2DSkeleton GetValue("LeftFootIndexRoot.kine.local.posx"), GetValue("LeftFootIndexRoot.kine.local.posy"), GetValue("LeftFootIndexRoot.kine.local.posz"), GetValue("LeftFootIndex1.kine.local.posx"), GetValue("LeftFootIndex1.kine.local.posy"), GetValue("LeftFootIndex1.kine.local.posz"), 0, 0, 0, 4
	AppendBone "eff", GetValue("LeftFootIndexEff.kine.local.posx"), GetValue("LeftFootIndexEff.kine.local.posy"), GetValue("LeftFootIndexEff.kine.local.posz")

	DeleteObj "LeftFootIndexRoot,LeftFootIndex1,LeftFootIndexEff"
	SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name", Array("LeftFootIndexRoot", "LeftFootIndex1", "LeftFootIndex2", "LeftFootIndexEff")

	'''' create, rename, resize, parent left toe middle
	'------------------------------------------------------
	Create2DSkeleton GetValue("LeftFootMiddleRoot.kine.local.posx"), GetValue("LeftFootMiddleRoot.kine.local.posy"), GetValue("LeftFootMiddleRoot.kine.local.posz"), GetValue("LeftFootMiddle1.kine.local.posx"), GetValue("LeftFootMiddle1.kine.local.posy"), GetValue("LeftFootMiddle1.kine.local.posz"), 0, 0, 0, 4
	AppendBone "eff", GetValue("LeftFootMiddleEff.kine.local.posx"), GetValue("LeftFootMiddleEff.kine.local.posy"), GetValue("LeftFootMiddleEff.kine.local.posz")

	DeleteObj "LeftFootMiddleRoot,LeftFootMiddle1,LeftFootMiddleEff"
	SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name", Array("LeftFootMiddleRoot", "LeftFootMiddle1", "LeftFootMiddle2", "LeftFootMiddleEff")

	'''' create, rename, resize, parent left toe ring
	'-----------------------------------------------------
	Create2DSkeleton GetValue("LeftFootRingRoot.kine.local.posx"), GetValue("LeftFootRingRoot.kine.local.posy"), GetValue("LeftFootRingRoot.kine.local.posz"), GetValue("LeftFootRing1.kine.local.posx"), GetValue("LeftFootRing1.kine.local.posy"), GetValue("LeftFootRing1.kine.local.posz"), 0, 0, 0, 4
	AppendBone "eff", GetValue("LeftFootRingEff.kine.local.posx"), GetValue("LeftFootRingEff.kine.local.posy"), GetValue("LeftFootRingEff.kine.local.posz")

	DeleteObj "LeftFootRingRoot,LeftFootRing1,LeftFootRingEff"
	SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name", Array("LeftFootRingRoot", "LeftFootRing1", "LeftFootRing2", "LeftFootRingEff")

	'''' create, rename, resize, parent left toe pinky
	'-----------------------------------------------------
	Create2DSkeleton GetValue("LeftFootPinkyRoot.kine.local.posx"), GetValue("LeftFootPinkyRoot.kine.local.posy"), GetValue("LeftFootPinkyRoot.kine.local.posz"), GetValue("LeftFootPinky1.kine.local.posx"), GetValue("LeftFootPinky1.kine.local.posy"), GetValue("LeftFootPinky1.kine.local.posz"), 0, 0, 0, 4
	AppendBone "eff", GetValue("LeftFootPinkyEff.kine.local.posx"), GetValue("LeftFootPinkyEff.kine.local.posy"), GetValue("LeftFootPinkyEff.kine.local.posz")

	DeleteObj "LeftFootPinkyRoot,LeftFootPinky1,LeftFootPinkyEff"
	SetValue "root.Name,root.bone.Name,bone.bone1.Name,bone1.bone2.Name,root.eff.Name", Array("LeftFootPinkyRoot", "LeftFootPinky1", "LeftFootPinky2", "LeftFootPinkyEff")

	''''changes bone, root and effector sizes for the toes
	'------------------------------------------------------------
	SetValue "LeftFootThumb1.bone.size,LeftFootThumb2.bone.size,LeftFootIndex1.bone.size,LeftFootIndex2.bone.size,LeftFootMiddle1.bone.size,LeftFootMiddle2.bone.size,LeftFootRing1.bone.size,LeftFootRing2.bone.size,LeftFootPinky1.bone.size,LeftFootPinky2.bone.size", Array(0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25)
	SetValue "LeftFootPinkyEff.eff.size,LeftFootRingEff.eff.size,LeftFootMiddleEff.eff.size,LeftFootIndexEff.eff.size,LeftFootThumbEff.eff.size", Array(0.1, 0.1, 0.1, 0.1, 0.1)
	SetValue "LeftFootThumbRoot.root.size,LeftFootIndexRoot.root.size,LeftFootMiddleRoot.root.size,LeftFootRingRoot.root.size,LeftFootPinkyRoot.root.size", Array(0.1, 0.1, 0.1, 0.1, 0.1)

	''''set toe hierarchy
	'---------------------------
	ParentObj "B:LeftToeBase", "LeftFootThumbRoot,LeftFootIndexRoot,LeftFootMiddleRoot,LeftFootRingRoot,LeftFootPinkyRoot"'

	''''set neutral pose for toes
	'---------------------------------
	SetAndToggleSelection "LeftFootThumbRoot, LeftFootThumbEff, LeftFootIndexRoot, LeftFootIndexEff, LeftFootMiddleRoot, LeftFootMiddleEff, LeftFootRingRoot, LeftFootRingEff, LeftFootPinkyRoot, LeftFootPinkyEff"
	SetNeutralPose , siSRT

end if

''''''par deux
'------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------------------

''''create beginning heirarchy for FBX, rename and parent
'----------------------------------------------------------------
for i = 0 to 4
	GetPrim "Null"
next

SetValue "null.Name,null1.Name,null2.Name,null3.Name,null4.Name", Array("Human_Skeleton_D", "Reference", "GlobalSRT", "CONTROL", "COG")

ParentObj "B:Human_Skeleton_D", "Reference"
ParentObj "B:Human_Skeleton_D.Reference", "GlobalSRT"
ParentObj "B:Human_Skeleton_D.GlobalSRT", "CONTROL"
MatchTransform "COG", "Hips", siTrn
ParentObj "B:Human_Skeleton_D.CONTROL", "COG"
ParentObj "B:Human_Skeleton_D.GlobalSRT", "Hips"

''''select and mirror shoulder and leg chains
'-------------------------------------------------
DuplicateSymmetry "B:LeftUpLegRoot", , , 1, 0, 0, 0
DuplicateSymmetry "B:LeftShoulderRoot", , , 1, 0, 0, 0

''''rename right leg chain
'------------------------------
SetValue "LeftUpLegRoot1.Name,LeftUpLegRoot1.LeftUpLeg1.Name,LeftUpLeg1.LeftLeg1.Name,LeftUpLegRoot1.LeftLegEffector1.Name,LeftLegEffector1.LeftFootRoot1.Name,LeftFootRoot1.LeftFoot1.Name,LeftFoot1.LeftToeBase1.Name,LeftFootRoot1.LeftToeEffector1.Name", Array("RightUpLegRoot", "RightUpLeg", "RightLeg", "RightLegEffector", "RightFootRoot", "RightFoot", "RightToeBase", "RightToeEffector")

''''rename right shoulder, arm, hand chain
'-------------------------------------------------
SetValue "LeftShoulderRoot1.Name,LeftShoulderRoot1.LeftShoulder1.Name,LeftShoulderRoot1.LeftShoulderEffector1.Name,LeftArmRoot1.Name,LeftArmRoot1.LeftArm1.Name,LeftArm1.LeftForearm1.Name,LeftArmRoot1.LeftArmEffector1.Name,LeftHandRoot1.Name,LeftHandRoot1.LeftHand1.Name,LeftHandRoot1.LeftHandEffector1.Name", Array("RightShoulderRoot", "RightShoulder", "RightShoulderEffector", "RightArmRoot", "RightArm", "RightForearm", "RightArmEffector", "RightHandRoot", "RightHand", "RightHandEffector")

''''parent legs to hips, shoulders to spineEffector
'----------------------------------------------------------
ParentObj "B:Human_Skeleton_D.Hips", "LeftUpLegRoot,RightUpLegRoot"
ParentObj "B:Spine2", "RightShoulderRoot, LeftShoulderRoot"

''''rename right hand fingers
'-------------------------------------------
SetValue "LeftMiddleRoot1.Name,LeftMiddleRoot1.LeftHandMiddle4.Name,LeftHandMiddle4.LeftHandMiddle5.Name,LeftHandMiddle5.LeftHandMiddle6,LeftMiddleRoot1.LeftMiddleEffector1.Name.", Array("RightMiddleRoot", "RightHandMiddle1", "RightHandMiddle1", "RightHandMiddle1", "RightMiddleEffector")
SetValue "LeftPinkyRoot1.Name,LeftPinkyRoot1.LeftHandPinky4.Name,LeftHandPinky4.LeftHandPinky5.Name,LeftHandPinky5.LeftHandPinky6.Name,LeftPinkyRoot1.LeftPinkyEffector1.Name", Array("RightPinkyRoot", "RightHandPinky1", "RightHandPinky1", "RightHandPinky1", "RightPinkyEffector")
SetValue "LeftRingRoot1.Name,LeftRingRoot1.LeftHandRing4.Name,LeftHandRing4.LeftHandRing5.Name,LeftHandRing5.LeftHandRing6.Name,LeftRingRoot1.LeftRingEffector1.Name", Array("RightRingRoot", "RightHandRing1", "RightHandRing1", "RightHandRing1", "RightRingEffector")
SetValue "LeftThumbRoot1.Name,LeftThumbRoot1.LeftHandThumb4.Name,LeftHandThumb4.LeftHandThumb5.Name,LeftHandThumb5.LeftHandThumb6.Name,LeftThumbRoot1.LeftThumbEffector1.Name", Array("RightThumbRoot", "RightHandThumb1", "RightHandThumb2", "RightHandThumb3", "RightThumbEffector")
SetValue "LeftIndexRoot1.Name,LeftIndexRoot1.LeftHandIndex4.Name,LeftHandIndex4.LeftHandIndex5.Name,LeftHandIndex5.LeftHandIndex6.Name,LeftIndexRoot1.LeftIndexEffector1.Name", Array("RightIndexRoot", "RightHandIndex1", "RightHandIndex1", "RightHandIndex1", "RightIndexEffector")

'''' global toe variable not needed anymore
'----------------------------------------------
DeleteObj "Toes"

DeselectAll
LogMessage"Herro Juicy"