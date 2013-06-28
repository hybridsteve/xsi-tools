#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Version: 1.1
#Cinemanix Productions
#Release: 20071917
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=============================================================

"""Abstract: Prompts the user to rename the selected objects with
a prefix, name, and suffix based on the default accepted values
from motion builder. """

"""Script Use: Select an object or objects, run the script, and 
select the desired options for prefix, name, and suffix. Then, hit
the button and watch in horrer as your selected objects have their 
identities stripped from them forever and replaced by a soulless
mockery of the life they knew before. """

#Version History: Script has been updated to PythonScript
#=============================================================

from win32com.client import constants as c

aPrefixes = ["None","","Left","Left","Right","Right"]
			
			
aNames = ["FingerBase","FingerBase",
	"InHandThumb","InHandThumb",
	"InHandIndex","InHandIndex",
	"InHandMiddle","InHandMiddle",
	"InHandRing","InHandRing",
	"InHandPinky","InHandPinky",
	"InHandExtraFinger","InHandExtraFinger",
	"HandThumb","HandThumb",
	"HandIndex","HandIndex",
	"HandMiddle","HandMiddle",
	"HandRing","HandRing",
	"HandPinky","HandPinky",
	"HandExtraFinger","HandExtraFinger",
	"Shoulder","Shoulder",
	"Arm","Arm",
	"ArmRoll","ArmRoll",
	"ForeArm","ForeArm",
	"ForeArmRoll","ForeArmRoll", 
	"Hand","Hand",
	"UpLeg","UpLeg",
	"UpLegRoll","UpLegRoll",
	"Leg","Leg",
	"LegRoll","LegRoll",
	"Foot","Foot",
	"ToeBase","ToeBase",
	"InFootThumb","InFootThumb",
	"InFootIndex","InFootIndex",
	"InFootMiddle","InFootMiddle",
	"InFootRing","InFootRing",
	"InFootPinky","InFootPinky",
	"InFootExtraFinger","InFootExtraFinger",
	"FootThumb","FootThumb",
	"FootIndex","FootIndex",
	"FootMiddle","FootMiddle",
	"FootRing","FootRing",
	"FootPinky","FootPinky",
	"FootExtraFinger","FootExtraFinger",
	"Props","Props",
	"Reference","Reference",
	"Hips","Hips",
	"Spine","Spine",
	"Neck","Neck",
	"Head","Head"]
	

false=0
true=1
oRoot = Application.ActiveSceneRoot
#make sure script isn't present in the scene already
try:
	Application.DeleteObj("MB_Renamer_Script")
except Exception:
	print "Script did not exist."
	
oControlNull = oRoot.AddNull("MB Renamer Script")
oPSet = oControlNull.AddProperty("CustomProperty",false,"Prompt")


oPSet.AddParameter3("Prefix", c.siString)
oPSet.AddParameter3("Nameo", c.siString)
oPSet.AddParameter3("Suffix",c.siString)

oPPGLayout = oPSet.PPGLayout


oPPGLayout.AddGroup("Rename", true)
oPPGLayout.AddRow()

oPPGLayout.AddGroup("",false,25)
oItem = oPPGLayout.AddEnumControl("Prefix", aPrefixes, "Prefix" ,c.siControlCombo)
oPPGLayout.EndGroup()

oPPGLayout.AddGroup("",false,50)
oItem = oPPGLayout.AddEnumControl("Nameo", aNames, "Name", c.siControlCombo)
oPPGLayout.EndGroup()

oPPGLayout.AddGroup("",false,25)
oItem = oPPGLayout.AddItem("Suffix", "Suffix", c.siControlNumber)
oItem.SetAttribute("noslider", true)
oPPGLayout.EndGroup()
oPPGLayout.Endrow()
oItem = oPPGLayout.AddButton("Rename")
oPPGLayout.EndGroup()

oPPGLayout.Language = "PythonScript"
oPPGLayout.Logic = """def Rename_OnClicked():
	oSelection=Application.Selection
	p = Application.GetValue("MB_Renamer_Script.Prompt.Prefix")
	n = Application.GetValue("MB_Renamer_Script.Prompt.Nameo")
	s = Application.GetValue("MB_Renamer_Script.Prompt.Suffix")
	for thing in oSelection:
		thing.Name = p+n+s"""


Application.InspectObj(oPSet)