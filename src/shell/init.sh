#!/bin/bash

iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
write ##class(Security.Users).UnExpireUserPasswords("*")
do \$SYSTEM.OBJ.Load("/src/cls/init/install.cls", "ck") 
set sc = ##class(init.install).init() 
zn "interop"
write ##class(Ens.Director).SetAutoStart("INTEROP.production")
write ##class(Ens.Director).StartProduction("INTEROP.production")
write ##class(Ens.Config.Credentials).SetCredential("IRIS","_system","SYS",1)
halt
END
exit=$?