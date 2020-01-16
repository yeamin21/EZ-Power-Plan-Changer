# EZ-Power-Plan-Changer

## One click power plan changer for windows OS (Checked on windows 10), developed using windows Powershell

## Features:
* No installation, lightweight 
* 1-click power plan change, no need to traverse through control panel or app setting blah blah..
* 1-click Ultimate Power Plan activation rather than searching internet and activating manually


![EZPPC](https://github.com/yeamin21/EZ-Power-Plan-Changer/blob/master/Snap.png)

## For Development:
### For script without icon embedded:
To use an icon, the icon must be loaded into the script.
to add the icon to form:-
1. Download the 'PPIcon.ico' to a preferred location
2. Add $<form name>.Icon="<Preffered location" i.e: $main_form.Icon="C:\Users\yeami\Desktop\PPIcon.ico"
3. Changing the icon directory will always show error unless the location is set to the changed directory

### For script with icon embedded:

base64 conversion used to convert string to image. First converted the icon to string, then string to an icon to embed the icon into the form. This one requires no changes to use the icon. To customize the icon of this projcet:
1. Convert image to base64:
powershell -> [convert]::ToBase64String((get-content C:\YourPicture.jpg -encoding byte)) > C:\YourString.txt
2. Open and copy the contents of the textfile, it will be quite long 
3. set $main_form.Icon=[System.Convert]::FromBase64String('<your copied text>')
  
ref: https://stackoverflow.com/questions/32397719/include-pictures-while-converting-ps1-to-exe-with-powergui

