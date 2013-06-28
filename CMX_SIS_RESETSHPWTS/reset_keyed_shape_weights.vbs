''''Author: Stephen Wagner
''''Requested: Matt Kapfhammer
''''Version: 1.0
''''Cinemanix Productions
''''Release: 20070823

''''For 5.11
'''''''''''''''''''''''''''''''''''''''''''''

'To select only the shapes controlled by keyframing (as opposed to driven by another 
'object's rotation, for example), select them, delete all their keys, and reset the 
'slider to 0 for each shape

'Matt wants the script to differentiate between keyed and driven shapes automatically.
'This is currently unworkable and defeats the purpose of naming conventions, but it 
'would be useful to look into how this can be done.

'dim oList

DeselectAll

SelectObj "*KEYED*"

for each item in Selection
	RemoveAllAnimation
	LogMessage item
	on error resume next
	SetValue item & ".actionclip.weight", 0.0
next
DeselectAll



'PsuedoCode
'=================================

'deselect all objects

'Select objects with the word "KEYED" in their names

'for each of the selected objects
	'remove all animation keys
	'log the name of the object
	'skip objects that do not have a weight parameter
	'set the weight parameter for each object to 0.0
'end for loop
'deselect all objects again