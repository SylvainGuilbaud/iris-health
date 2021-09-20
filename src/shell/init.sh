#!/bin/bash

iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
write ##class(Security.Users).UnExpireUserPasswords("*")
do \$SYSTEM.OBJ.Load("/src/app/install.cls", "ck") 
set sc = ##class(app.install).init() 
halt
END
exit=$?