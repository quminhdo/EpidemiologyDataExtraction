Attribute VB_Name = "Module1"
Sub Main()
   
    Dim Source_Folder_Path As String, Target_Folder_Path As String
    Dim File_Names As String
    Dim doc As Document
   
    '// Step 1. Assign Folder Paths
    Source_Folder_Path = "C:\Users\khoam\OneDrive\Desktop\pdf"
   Target_Folder_Path = "C:\Users\khoam\OneDrive\Desktop\out"
   
    If Right(Source_Folder_Path, 1) <> "\" Then
        Source_Folder_Path = Source_Folder_Path & "\"
    End If
   
    If Right(Target_Folder_Path, 1) <> "\" Then
        Target_Folder_Path = Target_Folder_Path & "\"
    End If
   
    '// Step 2. Grad all the PDF files
   
    File_Names = Dir(Source_Folder_Path & "*.pdf")
   
    Application.DisplayAlerts = wdAlertsNone
   
    Do While File_Names <> ""
        Set doc = Documents.Open(Source_Folder_Path & File_Names, False)
        '// Convert the PDF file to Word Doc
        doc.SaveAs2 Target_Folder_Path & Replace(File_Names, ".pdf", ".docx"), wdFormatDocumentDefault
        doc.Close False
       
        Set doc = Nothing
       
        File_Names = Dir()
    Loop
    Application.DisplayAlerts = wdAlertsAll
   
    MsgBox "Conversion is finished"
End Sub

