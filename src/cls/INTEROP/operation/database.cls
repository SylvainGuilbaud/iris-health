Class INTEROP.operation.database Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Property SCHEMA As %String [ InitialExpression = "PATIENT_data" ];

Parameter SETTINGS = "SCHEMA:app";

Method nb(pRequest As INTEROP.msg.count, Output pResponse As INTEROP.msg.countResponse) As %Status
{
	
	set sc = $$$OK
	
	try{
		set pResponse = ##class(INTEROP.msg.countResponse).%New()
		set query = "",hasNext=""
		set query = query_"SELECT count(*) as nb FROM "_ ..SCHEMA_"."_pRequest.tablename

		$$$TRACE(query)

		$$$ThrowOnError(..Adapter.ExecuteQuery(.rs,query))

		if rs.%Next() {
			set nb = rs.%Get("nb")
			$$$LOGINFO("nb:" _ nb)
		} else {
			$$$LOGINFO("NO DATA FOUND")
		}
		
		set pResponse.nb = nb
	}
	catch exp
	{
		set sc = exp.AsStatus()
	}
	return sc
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="INTEROP.msg.count"> 
		<Method>nb</Method>
	</MapItem>
</MapItems>
}

}
