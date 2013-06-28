''''Author: SKW
''''Ver: 0.1a
''''Cinemanix Productions
''''Release: -1

''''Export Granules - Character
''''A single script that prompts the user to export all the usual aspects of the character
''''END GOAL

'A single script that upon running gives the user a ppg that prompts the user to choose what granules to export [Geometry (.emdl, .obj or .xsi?), Material (.preset), Weights (.preset), Rig
'(.emdl), Constraints (action clip), Expressions (action clip), Animation (action clip)]. You would check those that you which to export and then, in the text field that is beside the granule's name 
'(it is grayed out and un-selectable until that granule's box is checked) type in the intended name for the granule. After marking and naming the granules, click the "export" button at the bottom of that ppg.
' The script looks for these objects' properties by starting at selected root nodes (model nulls more than likely) and looking in their hierarchies.

''''END GOAL

''''Notes

''''declare groups and variables

dim oGeometry, oMaterial, oWeights, oRig, oConstraints, oExpressions, oAnimation, oProperties, oRoot, oNull, oLayout, _
oGeometryName, oMaterialName, oWeightsName, oRigName, oConstraintsName, oExpressionsName, oAnimationName
DeselectAll

set oRoot = Application.ActiveProject.ActiveScene.Root



set oNull = oRoot.AddGeometry("Null", "","Export Granules")

set oProperties = oNull.AddProperty("Custom_parameter_list",,"Select Character Granules to Export")

AddCustomParams(oProperties)


set oLayout = oProperties.PPGLayout

oLayout.AddGroup "Note",true,100
oLayout.AddItem "StringNote", "Note:", siString
oLayout.EndGroup

oLayout.AddGroup "Geometry",true,70
oLayout.AddItem "BoolGeometry","Export Geometry", siBool
set oGeometry = oLayout.AddItem ("StringGeometryPath","Export Folder", siControlFolder)
oGeometry.SetAttribute siUIInitialDir, "project"
set oGeometryPath = oLayout.AddItem ("StringGeometryName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Material", true, 60
oLayout.AddItem "BoolMaterial","Export Material", siBool
set oMaterial = oLayout.AddItem ("StringMaterialPath","Export Folder", siControlFolder)
oMaterial.SetAttribute siUIInitialDir, "project"
set oMaterialPath = oLayout.AddItem ("StringMaterialName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Weights", true, 100
oLayout.AddItem "BoolWeights","Export Weight Presets", siBool
set oWeights = oLayout.AddItem ("StringWeightsPath","Export Folder",siControlFolder)
oWeights.SetAttribute siUIInitialDir, "project"
set oWeightsPath = oLayout.AddItem ("StringWeightsName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Rig", true, 100
oLayout.AddItem "BoolRig","Export Rig", siBool
set oWeights = oLayout.AddItem ("StringRigPath","Export Folder",siControlFolder)
oWeights.SetAttribute siUIInitialDir, "project"
set oRigPath = oLayout.AddItem ("StringRigName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Constraints", true, 100
oLayout.AddItem "BoolConstraints","Export Constraints Clip", siBool
set oWeights = oLayout.AddItem ("StringConstraintsPath","Export Folder",siControlFolder)
oWeights.SetAttribute siUIInitialDir, "project"
set oConstraintsPath = oLayout.AddItem ("StringConstraintsName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Expressions", true, 100
oLayout.AddItem "BoolWeights","Export Expressions Clip", siBool
set oWeights = oLayout.AddItem ("StringExpressionsPath","Export Folder",siControlFolder)
oWeights.SetAttribute siUIInitialDir, "project"
set oExpressionsPath = oLayout.AddItem ("StringExpressionsName","File Name", siString)
oLayout.EndGroup

oLayout.AddGroup "Animation", true, 100
oLayout.AddItem "BoolWeights","Export Animation Clip", siBool
set oWeights = oLayout.AddItem ("StringAnimationPath","Export Folder",siControlFolder)
oWeights.SetAttribute siUIInitialDir, "project"
set oAnimationPath = oLayout.AddItem ("StringAnimationName","File Name", siString)
oLayout.EndGroup

InspectObj oProperties


sub AddCustomParams (in_customprop)

   On Error Resume Next

   set oParam1 = in_customprop.AddParameter ("BoolGeometry", siBool, , ,"Export Geometry (.emdl)", "Export Geometry (.emdl format)", ,false)
   write_customprop oParam1

   set oParam2 = in_customprop.AddParameter ("BoolMaterial", siBool, , ,"Export Materials (.preset)", "Export Geometry (.preset format)", ,false)
   write_customprop oParam2

   set oParam3 = in_customprop.AddParameter ("BoolWeights", siBool, , ,"Export Weights (.preset)", "Export Weights (.preset format)", ,false)
   write_customprop oParam3
   
   set oParam4 = in_customprop.AddParameter ("BoolRig", siBool, , ,"Export Rig (.emdl)", "Export Rig (.emdl format)", ,false)
   write_customprop oParam4
   
   set oParam5 = in_customprop.AddParameter ("BoolConstraints",siBool, , ,"Export Constraints (action clip)", "Export Constraints (action clip)", ,false)
   write_customprop oParam5
   
   set oParam6 = in_customprop.AddParameter ("BoolExpressions", siBool, , ,"Export Expressions (action clip)", "Export Expressions (action clip)", ,false)
   write_customprop oParam6
   
   set oParam7 = in_customprop.AddParameter ("BoolAnimation", siBool, , ,"Export Animation (action clip)", "Export Animation (action clip)", ,false)
   write_customprop oParam7
   
   set oParam8 = in_customprop.AddParameter ("StringGeometryPath", siString, , ,"GeomPath","Exported Geometry Path")
   write_customprop oParam8
   
   set oParam9 = in_customprop.AddParameter ("StringMaterialPath", siString, , ,"MatPath","Exported Material Path")
   write_customprop oParam9
   
   set oParam10 = in_customprop.AddParameter ("StringWeightsPath", siString, , ,"WeightPath","Exported Weights Path")
   write_customprop oParam10
   
   set oParam11 = in_customprop.AddParameter ("StringRigPath", siString, , ,"RigPath","Exported Rig Path")
   write_customprop oParam11
   
   set oParam12 = in_customprop.AddParameter ("StringConstraintsPath",siString, , ,"ConPath","Exported Constraints Path")
   write_customprop oParam12
   
   set oParam13 = in_customprop.AddParameter ("StringExpressionsPath",siString, , ,"ExpPath","Exported Expression Path")
   write_customprop oParam13
   
   set oParam14 = in_customprop.AddParameter ("StringAnimationPath",siString, , ,"AnimPath","Exported Animation Path")
   write_customprop oParam14
   
   set oParam15 = in_customprop.AddParameter ("StringNote",siString, , ,"If you close this window, it can be accessed in the custom properties of the Export_Granules null","long", ,"If you close this window, it can be accessed in the custom properties of the Export_Granules null")
   set oParam16 = in_customprop.AddParameter ("StringGeometryName",siString, , ,"short","long", ,"exported_geometry")
   set oParam17 = in_customprop.AddParameter ("StringMaterialName",siString, , ,"short","long", ,"exported_material")
   set_oParam18 = in_customprop.AddParameter ("StringWeightsName",siString, , ,"short","long", ,"exported_weights")
   set_oParam19 = in_customprop.AddParameter ("StringRigName",siString, , ,"short","long", ,"exported_rig")
   set_oParam20 = in_customprop.AddParameter ("StringConstraintsName",siString, , ,"short","long", ,"exported_constraints")
   set_oParam21 = in_customprop.AddParameter ("StringExpressionsName",siString, , ,"short","long", ,"exported_expressions")
   set_oParam22 = in_customprop.AddParameter ("StringAnimationName",siString, , ,"short","long", ,"exported_animation")
   

end sub
