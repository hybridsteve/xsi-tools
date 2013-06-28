#Author: Stephen Wagner
#Requested: Matt Kapfhammer
#Version: 1.1
#Cinemanix Productions
#Release: 20070823
#Language: Python

#For XSI 5.11 on Windows 2k/XP
#=================================================================================

#Abstract: A script for taking any keyframable shapes (designated as such)
#and removing all of their keys and resetting them to 0, useful for a new
#scene where the same shapes will be used.

#Script Use: All you need to do is run the script on its own. 

#Matt wants the script to differentiate between keyed and driven shapes automatically.
#This is currently unworkable and defeats the purpose of naming conventions, but it 
#would be useful to look into how this can be done.

#Version History: Script transcribed to Python!
#===================================================================================

xsi = Application

xsi.DeselectAll()

xsi.SelectObj("*KEYED*")

for item in xsi.Selection:
        xsi.RemoveAllAnimation()
        xsi.LogMessage(item)
        try:
            xsi.SetValue(item & ".actionclip.weight", 0.0)
        except Exception:
            xsi.LogMessage("Oops.")

xsi.DeselectAll()



#PsuedoCode
#=================================

#deselect all objects

#Select objects with the word "KEYED" in their names

#for each of the selected objects
#   remove all animation keys
#	log the name of the object
#	skip objects that do not have a weight parameter
#	set the weight parameter for each object to 0.0
#end for loop
#deselect all objects again