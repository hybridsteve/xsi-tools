''''Author: Stephen Wagner
''''Version: 1.2
''''Cinemanix Productions
''''Release Date: 20070425

''''Release Notes: save preset weights with same name as selected object, (possibly) into folder with same name as scene/file

''''v1.2 notes:
''''commented out surreptitious error message
''''changed exported file name structure


'''''for 5.11
''''''''''''''''''''''''''''''''''''''''''''''''''''

'''''declare that 
''''''''''''''''''''''''''''''''''''''''''''''''''''

dim oItemName, oFileName, oSavePathName, fb, oError, oParentName
'set fb = XSIUIToolkit.FileBrowser



oSavePathName = ActiveProject.Path & "\WEIGHT_PRESETS"


''''get meshes from selection and export weight presets
'''''''''''''''''''''''''''''''''''''''''''''''''''''

'set oFileName = FileName()

for each item in Selection
	if typename(item) = "X3DObject" then
		oItemName = item.parent.parent & "_wts_" & item.Name
		On Error Resume Next
		SavePreset item, oItemName, oSavePathName, , False
		'msgbox "For  " & item.Name & ": preset already exists - Doctor Steve"
	else
		end if
next
