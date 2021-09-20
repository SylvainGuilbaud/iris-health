#!/bin/bash

iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
write ##class(Security.Users).UnExpireUserPasswords("*")
do \$SYSTEM.OBJ.Load("/src/app/install.cls", "ck") 
set sc = ##class(app.install).init() 
zn "app"
set recurse = 1
set dir = "/src/cls"
do \$system.OBJ.LoadDir(dir,"ck",.errors,1)
merge ^INIT.ERRORS(dir)=errors
halt
END
exit=$?