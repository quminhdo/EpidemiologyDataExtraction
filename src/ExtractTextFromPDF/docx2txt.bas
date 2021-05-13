Sub Main()
   
    Dim Source_Folder_Path As String, Target_Folder_Path As String
    Dim File_Names As String
    Dim doc As Document
   
    '// Step 1. Assign Folder Paths
    Source_Folder_Path = "C:\Users\khoam\OneDrive\Desktop\docx"
    Target_Folder_Path = "C:\Users\khoam\OneDrive\Desktop\txt"
   
    If Right(Source_Folder_Path, 1) <> "\" Then
        Source_Folder_Path = Source_Folder_Path & "\"
    End If
   
    If Right(Target_Folder_Path, 1) <> "\" Then
        Target_Folder_Path = Target_Folder_Path & "\"
    End If
   
    '// Step 2. Grad all the PDF files
   
    '// Prepare to convert the Word Doc to .txt file
    xFolder = Source_Folder_Path
    xFileStr = Dir(xFolder & "\*.docx")
    xActPath = ""
    While xFileStr <> ""
        xFilePath = Target_Folder_Path & "\" & xFileStr
        If xFilePath <> xActPath Then
            Set xDoc = Documents.Open(xFilePath, AddToRecentFiles:=False, Visible:=False)
            xDoc.Activate
            For Each shp In ActiveDocument.Shapes
                If shp.Type = msoGroup Then
                    ' copy text to string, without last paragraph mark
                    For x = 1 To shp.GroupItems.Count
                        If shp.GroupItems(x).Type = msoTextBox Then
                            ' copy text to string, without last paragraph mark
                            sString = Left(shp.GroupItems(x).TextFrame.TextRange.Text, _
                              shp.GroupItems(x).TextFrame.TextRange.Characters.Count - 1)
                            If Len(sString) > 0 Then
                                ' set the range to insert the text
                                Set oRngAnchor = shp.Anchor.Paragraphs(1).Range
                                ' insert the textbox text before the range object
                                oRngAnchor.InsertBefore _
                                  "Textbox start << " & sString & " >> Textbox end"
                            End If
                        End If
                      
                    Next x
                ElseIf shp.Type = msoTextBox Then
                    ' copy text to string, without last paragraph mark
                    sString = Left(shp.GroupItems(x).TextFrame.TextRange.Text, _
                      shp.GroupItems(x).TextFrame.TextRange.Characters.Count - 1)
                    If Len(sString) > 0 Then
                        ' set the range to insert the text
                        Set oRngAnchor = shp.Anchor.Paragraphs(1).Range
                        ' insert the textbox text before the range object
                        oRngAnchor.InsertBefore _
                          "Textbox start << " & sString & " >> Textbox end"
                    End If
                End If
            Next shp
          
            xIndex = InStrRev(xFilePath, ".")
            Debug.Print Left(xFilePath, xIndex - 1) & ".txt"
            ActiveDocument.SaveAs Left(xFilePath, xIndex - 1) & ".txt", FileFormat:=wdFormatText, AddToRecentFiles:=False
            ActiveDocument.Close True
        End If
        xFileStr = Dir()
    Wend
    Application.DisplayAlerts = wdAlertsAll
   
    MsgBox "Conversion is finished"
End Sub

