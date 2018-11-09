---
layout: post
title:  "How to Install Excel Add-Ins with VBA"
date:   2017-01-11
categories: vba
tags: vba excel add-in
---

### Goal
  
Install or update an Excel add-in programmatically using VBA by double-clicking on an add-in *.xlam file.  
  
### Algorithm and Code

1. **Important**
	* The code has to reside in the ```ThisWorkbook``` object (not in a Module!). 
	* The workbook must have a **title** (File -> Info -> Properties -> Title).  
	This title will determine the name of your add-in as displayed in the add-ins window.  
	 
2. Add-in opening will prompt a ```Workbook_Open``` event.  
**Important**:  
: The event will be launched whether the add-in is opened programmatically or manually. After installation, add-in is opened programmatically every time Excel is launched.  

3. Explicitly declare all variables.  
**Important**:  
: Change the line ```"desired_addin_name.xlam"``` in the code below to the desired add-in filename. The idea is when the add-in is installed or updated it will always have the **exact same filename** in the default MS Office add-ins directory. This is very important. If the filenames of the different add-in versions are different in that directory, a new version will not be "installed" (i.e. activated).  

   ```vb
	Option Explicit
	Private Sub Workbook_Open()
		Dim eai As Excel.addin
		Dim fso As Object
		Dim oXL As Object
		Dim response As Integer
		Dim thisAddInDate As Date
		Dim thisFileLen As Long
		Dim existingAddInName As String
		Dim existingAddinDate As Date
		Dim existingFileLen As Long
		Dim ai As addin
		Dim msg As String
		Dim toInstall As Integer
		Dim copiedWbName As String
		Dim desiredAddInName As String: desiredAddInName = "desired_addin_name.xlam"
		Dim deleteOld As Boolean: deleteOld = True
   ```
	
4. Get a full date and size of the open workbook.  
Next, loop through existing add-ins, and compare the Title of every add-in to the Title of the open Workbook.  
If there's a match, get the name of the existing add-in, and break out of the loop.  

   ```vb
		On Error GoTo Errorhandler
		
		'this wb's full name
		thisAddInDate = FileDateTime(ThisWorkbook.FullName)
		thisFileLen = FileLen(ThisWorkbook.FullName)
		existingAddInName = ""
		
		'find if this workbooks title
		'is the same as the title of one of the addins
		For Each ai In Application.AddIns
		Debug.Print ai.Title
			If ai.Title = ThisWorkbook.Title Then
				existingAddInName = ai.FullName
				Exit For
			End If
		Next ai
   ```

5. If the add-in already exists, get it's full name, and then look up the size and latest creation/modification date.  
Then compare the dates and sizes of the existing and open files.  
If sizes are different, prompt for an update.   
If sizes are the same -- quit, but if they are different, prompt for an update.  

   ```vb
		'if addin with the required title exists
		If existingAddInName <> "" Then
			'get existing addin's date and length
			existingAddinDate = FileDateTime(existingAddInName)
			existingFileLen = FileLen(existingAddInName)
			
			'if the open file is newer and its length is different
			If thisAddInDate > existingAddinDate And thisFileLen <> existingFileLen Then
				msg = "Do you want to update the addin?"
			'else if the open file is older (or same) and its length is different
			ElseIf thisAddInDate <= existingAddinDate And thisFileLen <> existingFileLen Then
				msg = "Do you want to update the addin?" & vbNewLine & _
				"The file you opened is not newer than the installed file."
			Else
			'if file lengths are the same, exit
				Exit Sub
			End If
		Else
			'if there's no desired addin, prompt to install
			msg = "Do you want to install the Rancho Tools?"
			'and assign a desired value to the "existing" name
			existingAddInName = Application.UserLibraryPath & desiredAddInName
		End If
   ```

6. Prompt whether to install/update the plugin.  

   ```vb
		toInstall = MsgBox(msg, vbYesNo)
   ```

7. If install/update:  
	* Uninstall and delete the old add-in (if it exists);  
	* Copy the file to the default add-ins location; 
	* **Important**:  
	Rename the copied file such that its names is the same as its previous version (i.e. the desired add-in name).
	* **Important**:  
	Open a dummy workbook to avoid an error #1004 (known bug);  
	* Add add-in to add-ins collection and install.  
  
   ```vb
		'if the user agreed to install
		If toInstall = vbYes Then
			'create a file system object to copy the file
			'into addins default folder
			Set fso = CreateObject("Scripting.FileSystemObject")
			
			'uninstall and delete the old addin
			If deleteOld Then
				'uninstall the existing addin
				ai.Installed = False
				'and delete the file
				Kill existingAddInName
			End If
			
			'copy new file to default user addin library
			fso.CopyFile ThisWorkbook.FullName, Application.UserLibraryPath, True
			
			'open a dummy workbook to avoid an error
			'the reason is, add method is only available if a workbook is open
			If Application.ActiveWorkbook Is Nothing Then
				Application.Workbooks.Add
			End If
			
			'change the filename to existing (and/or desired) filename
			'this is absolutely mandatory due to the quirks of Excel
			'add-in handling. If you don't do that, and filenames
			'of new version and old version are different, addin won't be installed.
			copiedWbName = Application.UserLibraryPath & ThisWorkbook.Name
			Name copiedWbName As existingAddInName
			
			'add and install the addin
			Set eai = Application.AddIns.Add(Filename:=copiedWbName)
			eai.Installed = True        
		End If
   ```

8. Quit Excel application.  

   ```vb  
		'pretend application is saved
		ThisWorkbook.Saved = True
		'and quit (close)
		Application.Quit
	  
	Exit Sub

	Errorhandler:
	MsgBox "Error #" & _
		Err.Number & _
		vbCrLf & _
		"Please, let Ivan know.", vbInformation

	End Sub  
   ```

Done!  

### Full Code

```vb
Option Explicit
Private Sub Workbook_Open()
    Dim eai As Excel.addin
    Dim fso As Object
    Dim oXL As Object
    Dim response As Integer
    Dim thisAddInDate As Date
    Dim thisFileLen As Long
    Dim existingAddInName As String
    Dim existingAddinDate As Date
    Dim existingFileLen As Long
    Dim ai As addin
    Dim msg As String
    Dim toInstall As Integer
    Dim copiedWbName As String
    Dim desiredAddInName As String: desiredAddInName = "desired_addin_name.xlam"
	Dim deleteOld As Boolean: deleteOld = True

    On Error GoTo Errorhandler
    
    'this wb's full name
    thisAddInDate = FileDateTime(ThisWorkbook.FullName)
    thisFileLen = FileLen(ThisWorkbook.FullName)
    existingAddInName = ""
    
    'find if this workbooks title
    'is the same as the title of one of the addins
    For Each ai In Application.AddIns
        If ai.Title = ThisWorkbook.Title Then
            existingAddInName = ai.FullName
            Exit For
        End If
    Next ai
    
    'if addin with the required title exists
    If existingAddInName <> "" Then
        'get existing addin's date and length
        existingAddinDate = FileDateTime(existingAddInName)
        existingFileLen = FileLen(existingAddInName)
        
        'if the open file is newer and its length is different
        If thisAddInDate > existingAddinDate And thisFileLen <> existingFileLen Then
            msg = "Do you want to update the Rancho Tools?"
        'else if the open file is older (or same) and its length is different
        ElseIf thisAddInDate <= existingAddinDate And thisFileLen <> existingFileLen Then
            msg = "Do you want to update the Rancho Tools?" & vbNewLine & _
            "The file you opened is not newer than the installed file."
        Else
        'if file lengths are the same, exit
            Exit Sub
        End If
    Else
        'if there's no desired addin, prompt to install
        msg = "Do you want to install the Rancho Tools?"
        'and assign a desired value to the "existing" name
        existingAddInName = Application.UserLibraryPath & desiredAddInName
    End If
    
    toInstall = MsgBox(msg, vbYesNo)
    
    'if the user agreed to install
    If toInstall = vbYes Then
        'create a file system object to copy the file
        'into addins default folder
        Set fso = CreateObject("Scripting.FileSystemObject")
        
        'uninstall and delete the old addin
        If deleteOld Then
            'uninstall the existing addin
            ai.Installed = False
            'and delete the file
            Kill existingAddInName
        End If
        
        'copy new file to default user addin library
        fso.CopyFile ThisWorkbook.FullName, Application.UserLibraryPath, True
        
        'open a dummy workbook to avoid an error
        'the reason is, add method is only available if a workbook is open
        If Application.ActiveWorkbook Is Nothing Then
            Application.Workbooks.Add
        End If
        
        'change the filename to existing (and/or desired) filename
        'this is absolutely mandatory due to the quirks of Excel
        'add-in handling. If you don't do that, and filenames
        'of new version and old version are different, addin won't be installed.
        copiedWbName = Application.UserLibraryPath & ThisWorkbook.Name
        Name copiedWbName As existingAddInName
        
        'add and install the addin
        Set eai = Application.AddIns.Add(Filename:=existingAddInName)
        eai.Installed = True
    End If
        'pretend application is saved
        ThisWorkbook.Saved = True
        'and quit (close)
        Application.Quit
      
    Exit Sub

Errorhandler:
    MsgBox "Error #" & _
        Err.Number & _
        vbCrLf & _
        "Please, let Ivan know.", vbInformation

End Sub
```