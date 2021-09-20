Class app.install
{

XData install [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Default Name="NAMESPACE" Value="APP"/>
  <Default Name="DBNAME" Value="APP"/>
  <Default Name="APPPATH" Dir="/data/" />
  <!-- <Default Name="SOURCESPATH" Dir="${APPPATH}src" /> -->
  <Default Name="RESOURCE" Value="%DB_${DBNAME}" /> 

  <Namespace Name="${NAMESPACE}" Code="${DBNAME}-CODE" Data="${DBNAME}-DATA" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${DBNAME}-CODE" Dir="${APPPATH}${DBNAME}-CODE" Create="yes" Resource="${RESOURCE}"/>
      <Database Name="${DBNAME}-DATA" Dir="${APPPATH}${DBNAME}-DATA" Create="yes" Resource="${RESOURCE}"/>
    </Configuration>

    <!-- <Import File="${SOURCESPATH}" Recurse="1"/> -->
    
  </Namespace>

</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "install")
}

ClassMethod init() As %Status
{
  set sc = $$$OK
  set sc = ..setup()
  set $namespace = "APP"
  // Enable analytics for the APP namespace.
  set app = $System.CSP.GetDefaultApp($namespace) _ "/"
  do EnableDeepSee^%SYS.cspServer(app)
  return sc
}

}
