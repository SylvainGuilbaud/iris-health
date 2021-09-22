#!/bin/bash

iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
do \$SYSTEM.OBJ.Load("/src/cls/init/install.cls", "ck") 
set sc = ##class(init.install).init() 
halt
END
exit=$?