''''Author: Chrystia Siolkowsky
''''Release 1.0
''''Cinemanix Productions
''''07.04.04

''''Release Notes:
'When you first run the script, you will be prompted with how many spine bones you want.  You can have more than 9 bones if you don't plan on importing into MotionBuilder.
'	Type a number and press 'Ok'
'Next you will be asked if your rig requires toes. 'Yes' if you want toes, 'No' if you don't.
'Once the nulls are created, move them to fit within your character. The skeleton is built only upon translational information, so don't worry about rotating.
'When all the nulls are in place, press the 'Make Skeleton' button.

''''spine prompt
'----------------------------------------------
dim Message
Message = "How many spine bones would you like? (1-9)"
dim Title
Title = "Spine Bones"

resultSpine = InputBox(Message,Title,, 500, 500)


''''toe prompt
'-----------------------------------------------
dim answer
answer=MsgBox("Do you want toes?",siMsgYesNo,"Toe Prompt")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(0, 11.3769136639475, -0.331642498358827, .5, "HipsNull")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(3.66121940162899E-15, 17.364586288299, -0.314780041690221, .5, "SpineEffectorNull")

dim diffX, diffY, diffZ
diffX = 3.66121940162899E-15/resultSpine
diffY = 5.9876726243515/resultSpine
diffZ = 0.016862456668606/resultSpine

''''create a series of nulls that become the spine
'----------------------------------------------------
for i = 1 to resultSpine-1
	GetPrim "Null"
	SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.primary_icon", Array(i*diffX, 11.3769136639475 + (i*diffY), -0.331642498358827 + (i*diffZ), .5, "SpineNull",2)
next

SelectAll

''''set the spine color
'-------------------------------------
for each null_item in Selection
	MakeLocal null_item & ".display", siNodePropagation
	SetValue null_item & ".display.wirecol", 480
next

DeselectAll

GetPrim "Null"
SetValue "null.Name, null.Size,null.visibility.viewvis", Array("spineNum", resultSpine, False)


''''create null neck, head, jaw
'--------------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(-7.42507792633029E-17, 18.6964126318341, -8.14462053610158E-02, .5, "Neck", 1002)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(3.74445090959382E-16, 20.3104372885847, -0.172611187461906, .5, "HeadEffector", 1002)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(-6.71874359184464E-16, 18.7420065486914, -5.40967107307489E-02, .35, "LowJaw", 990)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(-4.00118602467054E-16, 18.0672165792025, 0.966951088799227, .35, "JawEff", 990)

''''create junk
'-------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(-6.54966052989703E-17, 11.2021252079102, 7.56385114665138E-02, .35, "CrotchRoot", 222)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(1.64228160781244E-16, 10.3037955408116, 0.588841109322795, .35, "JunkEff", 222)

''''create left shoulder
'---------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(0.393490988538115, 17.0515339084753, 0, .5, "LeftShoulderRoot", 364)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(1.87101520650443, 17.1110372061362, -0.262063539635635, .5, "LeftShoulderEffector", 364)

''''create left arm
'---------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name,null.display.wirecol", Array(4.89130805565437, 16.9241474206732, -0.600000522758192, .5, "LeftArm", 364)

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name, null.display.wirecol", Array(7.94723241460702, 16.801591748298, -0.587912317040956, .5, "LeftArmEffector", 364)

''''create left hand
'---------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(364, 8.85947002058214, 16.7276958431596, -0.594014480511899, .35, "LeftHandEffector")

''''create left thumb
'--------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(478, 8.4178327251385, 16.6466011396428, -0.169141249875133, .1, "LeftThumbRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(478, 8.63447257285892, 16.5816011396428, 2.65177665183342E-02, .1, "LeftHandThumb1")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(478, 8.78242173715578, 16.5166011396428, 0.137567478525437, .1, "LeftHandThumb2")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(478, 8.95823016998775, 16.4124919155501, 0.24010161802357, .1, "LeftThumbEffector")

''''create left index
'-----------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(250, 9.02960251950604, 16.7948753445378, -0.29402458314941, .1, "LeftIndexRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(250, 9.30955281137934, 16.7785396900356, -0.266582907463239, .1, "LeftHandIndex1")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(250, 9.55842781110258, 16.7563501953108, -0.245733577588023, .1, "LeftHandIndex2")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(250, 9.75445519727046, 16.7159443036245, -0.239916389972456, .1, "LeftIndexEffector")

''''create left middle
'----------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(910, 9.05503710725097, 16.7948753445378, -0.507048704850401, .1, "LeftMiddleRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(910, 9.35926794827159, 16.8026252516135, -0.513349513637627, .1, "LeftHandMiddle1")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(910, 9.63015116892177, 16.7875023197624, -0.519563759550276, .1, "LeftHandMiddle2")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(910, 9.86118265926401, 16.7593182556583, -0.516711779980137, .1, "LeftMiddleEffector")

''''create left ring
'---------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(904, 8.99822820720483, 16.7948753445378, -0.732340480577494, .1, "LeftRingRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(904, 9.2439366120048, 16.7722045061161, -0.796610559483566, .1, "LeftHandRing1")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(904, 9.44497076138659, 16.7363856196273, -0.852497584619281, .1, "LeftHandRing2")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(904, 9.65576601630631, 16.6871774144549, -0.913325944815298, .1, "LeftRingEffector")

''''create left pinky
'------------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1008, 8.87710021271583, 16.6898445774416, -0.906187052088052, .1, "LeftPinkyRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1008, 9.07960479189958, 16.6798445774416, -1.02148092067968, .1, "LeftHandPinky1")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1008, 9.23082139781705, 16.6698445774416, -1.10328358756422, .1, "LeftHandPinky2")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1008, 9.38216476415357, 16.6556331680404, -1.17803396092052, .1, "LeftPinkyEffector")

''''create left leg
'-------------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(928, 0.776026466463343, 11.2908089085475, -0.204006126110121, .5, "LeftUpLegRoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(928, 1.43561658990614, 5.89711290904047, -1.38777878078145E-16, .5, "LeftUpLeg")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(928, 2.02629132909872, 0.908723545334563, -0.328617587177717, .5, "LeftLegEffector")

''''create left foot
'-------------------------------
GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(392, 2.17737998569746, 0.391210742612769, 0.750204358910301, .35, "LeftFoot")

GetPrim "Null"
MakeLocal "null.display", siNodePropagation
SetValue "null.display.wirecol,null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(392, 2.33554974944146, 0.205993221050981, 1.98775603430313, .35, "LeftToeEffector")

GetPrim "Null"
SetValue "null.Name,null.size,null.visibility.viewvis", Array("Toes", 1, False)

''''create toes
'------------------------
'-------------------------
if answer = 6 Then

''''create left foot thumb
'----------------------------
GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.5682, 0.2849, 0.8943, .1, "LeftFootThumbRoot")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.5539, 0.3245, 1.3907, .1, "LeftFootThumb1")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.5404, 0.2146, 1.896, .1, "LeftFootThumbEff")

''''create left foot index
'--------------------------------
GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.8318, 0.2818, 1.084, .1, "LeftFootIndexRoot")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.8554, 0.2789, 1.4237, .1, "LeftFootIndex1")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(1.8841, 0.2058, 1.8026, .1, "LeftFootIndexEff")

''''create left foot middle
'---------------------------------
GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.2061, 0.2429, 1.1037, .1, "LeftFootMiddleRoot")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.2474, 0.2566, 1.4306, .1, "LeftFootMiddle1")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.2824, 0.1638, 1.7201, .1, "LeftFootMiddleEff")

''''create left foot ring
'------------------------------------
GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.4753, 0.1677, 0.992, .1, "LeftFootRingRoot")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.524, 0.1819, 1.2693, .1, "LeftFootRing1")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.5692, 0.1285, 1.5111, .1, "LeftFootRingEff")

''''create left foot pinky
'-------------------------------------
GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.6657, 0.1282, 0.8081, .1, "LeftFootPinkyRoot")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.6951, 0.1408, 1.0546, .1, "LeftFootPinky1")

GetPrim "Null"
SetValue "null.kine.posX,null.kine.posY,null.kine.posZ,null.Size,null.Name", Array(2.7213, 0.0874, 1.2527, .1, "LeftFootPinkyEff")

''''creates null - used as a global variable in skeleton script, don't delete!
'-----------------------------------------------------------------
SetValue "Toes.size", 2

''''changes display icon of nulls - easier to select
'-----------------------------------------------------
SetValue "LeftFootThumb1.null.primary_icon,LeftFootThumbEff.null.primary_icon,LeftFootThumbRoot.null.primary_icon,LeftFootIndexRoot.null.primary_icon,LeftFootIndex1.null.primary_icon,LeftFootIndexEff.null.primary_icon,LeftFootMiddleRoot.null.primary_icon,LeftFootMiddle1.null.primary_icon,LeftFootMiddleEff.null.primary_icon,LeftFootRingRoot.null.primary_icon,LeftFootRing1.null.primary_icon,LeftFootRingEff.null.primary_icon,LeftFootPinkyRoot.null.primary_icon,LeftFootPinky1.null.primary_icon,LeftFootPinkyEff.null.primary_icon", Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)

end if

''''changes display icon of remaining nulls
'--------------------------------------------------------
SetValue "SpineEffectorNull.null.primary_icon,Neck.null.primary_icon,HeadEffector.null.primary_icon,LowJaw.null.primary_icon,JawEff.null.primary_icon,LeftShoulderRoot.null.primary_icon,LeftShoulderEffector.null.primary_icon,LeftArm.null.primary_icon,LeftThumbRoot.null.primary_icon,LeftHandThumb1.null.primary_icon,LeftHandThumb2.null.primary_icon,LeftThumbEffector.null.primary_icon,LeftIndexRoot.null.primary_icon,LeftHandIndex1.null.primary_icon,LeftHandIndex2.null.primary_icon,LeftIndexEffector.null.primary_icon,LeftMiddleRoot.null.primary_icon,LeftHandMiddle1.null.primary_icon,LeftHandMiddle2.null.primary_icon,LeftMiddleEffector.null.primary_icon,LeftRingRoot.null.primary_icon,LeftHandRing1.null.primary_icon,LeftHandRing2.null.primary_icon,LeftRingEffector.null.primary_icon,LeftPinkyRoot.null.primary_icon,LeftHandPinky1.null.primary_icon,LeftHandPinky2.null.primary_icon,LeftPinkyEffector.null.primary_icon,LeftArmEffector.null.primary_icon,LeftHandEffector.null.primary_icon,HipsNull.null.primary_icon,CrotchRoot.null.primary_icon,JunkEff.null.primary_icon,LeftUpLegRoot.null.primary_icon,LeftUpLeg.null.primary_icon,LeftLegEffector.null.primary_icon,LeftFoot.null.primary_icon,LeftToeEffector.null.primary_icon", Array(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2)

DeselectAll