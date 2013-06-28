CutObj "gtm_g04_ast1_rig_005_mjk_exp-imp-fbx.Human_Skeleton_D"

CreatePrim "Square", "NurbsCurve", "FBXControl"
MatchTransform "FBXControl", "Hips", siTrn
Rotate , 90, 0, 0, siAbsolute, siPivot, siObj, siX, , , , , , , , 0

ParentObj "B:FBXControl", "Human_Skeleton_D"

''''create hips controlller
'--------------------------
CreatePrim "Square", "NurbsCurve", "HipsControl"
MatchTransform "HipsControl", "Hips", siTrn
Rotate , 90, 0, 0, siAbsolute, siPivot, siObj, siX, , , , , , , , 0
SetValue "HipsControl.square.length", 4
ParentObj "B:HipsControl", "Hips"
ParentObj "B:FBXControl", "HipsControl"

''''create torso controller
'--------------------------
CreatePrim "Square", "NurbsCurve", "TorsoControl", "FBXControl"
Rotate , 0, 0, 45, siAbsolute, siPivot, siObj, siXZ, , , , , , , , 0
SetValue "TorsoControl.square.length", 4
MatchTransform "TorsoControl", "SpineEffector", siTrn
SetUserPref "SI3D_CONSTRAINT_COMPENSATION_MODE", 1
ApplyCns "Position", "SpineEffector", "TorsoControl", True

''''create right hand control
'----------------------------
GetPrim "Sphere", "rHandControl", "TorsoControl"
SetValue "rHandControl.sphere.radius", 1.75
MatchTransform "rHandControl", "RightHandEffector", siTrn

ApplyCns "Position", "RightArmEffector", "rHandControl", True
ApplyCns "Pose", "RightHand", "rHandControl", True
 

''''create left hand control
'---------------------------
GetPrim "Sphere", "lHandControl", "TorsoControl"
SetValue "lHandControl.sphere.radius", 1.75
MatchTransform "lHandControl", "LeftHandEffector", siTrn

ApplyCns "Position", "LeftArmEffector", "lHandControl", True
ApplyCns "Pose", "LeftHand", "lHandControl", True


''''create right foot control
'----------------------------
GetPrim "Cube", "rFootControl"
SetValue "rFootControl.cube.length", 1.75
MatchTransform "rFootControl", "RightLegEffector", siTrn
ApplyCns "Position", "RightLegEffector", "rFootControl", True
ApplyCns "Pose", "RightFoot", "rFootControl", True


''''create left foot control
'---------------------------
GetPrim "Cube", "lFootControl"
SetValue "lFootControl.cube.length", 1.75
MatchTransform "lFootControl", "LeftLegEffector", siTrn
ApplyCns "Position", "LeftLegEffector", "lFootControl", True
ApplyCns "Pose", "LeftFoot", "lFootControl", True


ParentObj "B:FBXControl", "lFootControl,rFootControl"

''''create head control
'-----------------------
CreatePrim "Circle", "NurbsCurve", "HeadControl", "TorsoControl"
SetValue "HeadControl.circle.radius", 2.25
MatchTransform "HeadControl", "HeadEffector", siTrn
Rotate , 0, 0, 0, siAbsolute, siPivot, siObj, siX, , , , , , , , 0

ApplyCns "Pose", "Head", "HeadControl", True

''''create right knee swivel
'----------------------------
GetPrim "Cone", "rKneeSwivel"
SetValue "rKneeSwivel.cone.height,rKneeSwivel.cone.radius", Array(1, .25)

MatchTransform "rKneeSwivel", "RightLeg", siTrn
Translate , 0, 0, 2.75, siRelative, siGlobal, siObj, siXYZ, , , , , , , , , , 0

ApplyOp "SkeletonUpVector", "RightUpLeg;rKneeSwivel", 3, siPersistentOperation, , 0


''''create left knee swivel
'--------------------------
GetPrim "Cone", "lKneeSwivel"
SetValue "lKneeSwivel.cone.height,lKneeSwivel.cone.radius", Array(1, .25)

MatchTransform "lKneeSwivel", "LeftLeg", siTrn
Translate , 0, 0, 2.75, siRelative, siGlobal, siObj, siXYZ, , , , , , , , , , 0

ApplyOp "SkeletonUpVector", "LeftUpLeg;lKneeSwivel", 3, siPersistentOperation, , 0


''''create left toe control
'--------------------------
GetPrim "Circle", "lToeControl", "lFootControl"
SetValue "lToeControl.circle.radius", 0.75
MatchTransform "lToeControl", "LeftFootEffector", siTrn

 
ApplyCns "Position", "LeftFootEffector", "lToeControl", True
ApplyCns "Pose", "LeftToeBase", "lToeControl", True  


''''create left toe control
'--------------------------
GetPrim "Circle", "rToeControl", "rFootControl"
SetValue "rToeControl.circle.radius", 0.75
MatchTransform "rToeControl", "RightFootEffector", siTrn

 
ApplyCns "Position", "RightFootEffector", "rToeControl", True
ApplyCns "Pose", "RightToeBase", "rToeControl", True  


''''create right elbow swivel
'--------------------------
GetPrim "Cone", "rElbowSwivel"
SetValue "rElbowSwivel.cone.height,rElbowSwivel.cone.radius", Array(1, .25)

MatchTransform "rElbowSwivel", "RightForeArm", siTrn
Translate , 0, 0, -2.75, siRelative, siGlobal, siObj, siXYZ, , , , , , , , , , 0

ApplyOp "SkeletonUpVector", "RightArm;rElbowSwivel", 3, siPersistentOperation, , 0

''''create left elbow swivel
'--------------------------
GetPrim "Cone", "lElbowSwivel"
SetValue "lElbowSwivel.cone.height,lElbowSwivel.cone.radius", Array(1, .25)

MatchTransform "lElbowSwivel", "LeftForeArm", siTrn
Translate , 0, 0, -2.75, siRelative, siGlobal, siObj, siXYZ, , , , , , , , , , 0

ApplyOp "SkeletonUpVector", "LeftArm;lElbowSwivel", 3, siPersistentOperation, , 0

ParentObj "B:FBXControl", "lElbowSwivel,lKneeSwivel,rElbowSwivel,rKneeSwivel"

''''create finger controllers - left hand
'----------------------------
GetPrim "Null", "lThumb"
MatchTransform "lThumb", "LeftThumbEffector", siTrn
SetValue "lThumb.null.primary_icon, lThumb.null.size", Array(4, .35)
ApplyCns "Position", "LeftThumbEffector", "lThumb"

GetPrim "Null", "lIndex"
MatchTransform "lIndex", "LeftIndexEffector", siTrn
SetValue "lIndex.null.primary_icon, lIndex.null.size", Array(4, .35)
ApplyCns "Position", "LeftIndexEffector", "lIndex"

GetPrim "Null", "lMiddle"
MatchTransform "lMiddle", "LeftMiddleEffector", siTrn
SetValue "lMiddle.null.primary_icon, lMiddle.null.size", Array(4, .35)
ApplyCns "Position", "LeftMiddleEffector", "lMiddle"

GetPrim "Null", "lRing"
MatchTransform "lRing", "LeftRingEffector", siTrn
SetValue "lRing.null.primary_icon, lRing.null.size", Array(4, .35)
ApplyCns "Position", "LeftRingEffector", "lRing"

GetPrim "Null", "lPinky"
MatchTransform "lPinky", "LeftPinkyEffector", siTrn
SetValue "lPinky.null.primary_icon, lPinky.null.size", Array(4, .35)
ApplyCns "Position", "LeftPinkyEffector", "lPinky"

ParentObj "B:lHandControl", "lIndex,lMiddle,lPinky,lRing,lThumb"

''''create finger controllers - right hand
'----------------------------------------
GetPrim "Null", "rThumb"
MatchTransform "rThumb", "rightThumbEffector", siTrn
SetValue "rThumb.null.primary_icon, rThumb.null.size", Array(4, .35)
ApplyCns "Position", "rightThumbEffector", "rThumb"

GetPrim "Null", "rIndex"
MatchTransform "rIndex", "rightIndexEffector", siTrn
SetValue "rIndex.null.primary_icon, rIndex.null.size", Array(4, .35)
ApplyCns "Position", "rightIndexEffector", "rIndex"

GetPrim "Null", "rMiddle"
MatchTransform "rMiddle", "rightMiddleEffector", siTrn
SetValue "rMiddle.null.primary_icon, rMiddle.null.size", Array(4, .35)
ApplyCns "Position", "rightMiddleEffector", "rMiddle"

GetPrim "Null", "rRing"
MatchTransform "rRing", "rightRingEffector", siTrn
SetValue "rRing.null.primary_icon, rRing.null.size", Array(4, .35)
ApplyCns "Position", "rightRingEffector", "rRing"

GetPrim "Null", "rPinky"
MatchTransform "rPinky", "rightPinkyEffector", siTrn
SetValue "rPinky.null.primary_icon, rPinky.null.size", Array(4, .35)
ApplyCns "Position", "rightPinkyEffector", "rPinky"

ParentObj "B:rHandControl", "rIndex,rMiddle,rPinky,rRing,rThumb"

SetValue "LeftHandEffector.visibility.selectability,LeftIndexRoot.visibility.selectability,LeftHandIndex1.visibility.selectability,LeftHandIndex2.visibility.selectability,LeftHandIndex3.visibility.selectability,LeftIndexEffector.visibility.selectability,LeftMiddleRoot.visibility.selectability,LeftHandMiddle1.visibility.selectability,LeftHandMiddle2.visibility.selectability,LeftHandMiddle3.visibility.selectability,LeftMiddleEffector.visibility.selectability,LeftPinkyRoot.visibility.selectability,LeftHandPinky1.visibility.selectability,LeftHandPinky2.visibility.selectability,LeftHandPinky3.visibility.selectability,LeftPinkyEffector.visibility.selectability,LeftRingRoot.visibility.selectability,LeftHandRing1.visibility.selectability,LeftHandRing2.visibility.selectability,LeftHandRing3.visibility.selectability,LeftRingEffector.visibility.selectability,LeftThumbRoot.visibility.selectability,LeftHandThumb2.visibility.selectability,LeftHandThumb3.visibility.selectability,LeftThumbEffector.visibility.selectability,LeftHandThumb1.visibility.selectability,RightHandEffector.visibility.selectability,RightIndexRoot.visibility.selectability,RightHandIndex1.visibility.selectability,RightHandIndex2.visibility.selectability,RightHandIndex3.visibility.selectability,RightIndexEffector.visibility.selectability,RightMiddleRoot.visibility.selectability,RightHandMiddle1.visibility.selectability,RightHandMiddle2.visibility.selectability,LeftHandMiddle6.visibility.selectability,RightMiddleEffector.visibility.selectability,RightPinkyRoot.visibility.selectability,RightHandPinky1.visibility.selectability,RightHandPinky2.visibility.selectability,RightHandPinky3.visibility.selectability,RightPinkyEffector.visibility.selectability,RightRingRoot.visibility.selectability,RightHandRing1.visibility.selectability,RightHandRing2.visibility.selectability,RightHandRing3.visibility.selectability,RightRingEffector.visibility.selectability,RightThumbRoot.visibility.selectability,RightHandThumb2.visibility.selectability,RightHandThumb3.visibility.selectability,RightThumbEffector.visibility.selectability,RightHandThumb1.visibility.selectability", Array(False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False, False)

SetUserPref "SI3D_CONSTRAINT_COMPENSATION_MODE", 0

CutObj "Human_Skeleton_D"
ParentObj "B:gtm_g04_ast1_rig_005_mjk_exp-imp-fbx", "Human_Skeleton_D"
ParentObj "B:FBXControl", "gtm_g04_ast1_rig_005_mjk_exp-imp-fbx"

DeselectAll