Class INTEROP.operation.archivage Extends Ens.BusinessOperation
{

Parameter ADAPTER;

Property ARCHIVAGE As %String [ InitialExpression = "PATIENT" ];

Parameter SETTINGS = "ARCHIVAGE:app";

Method HL7(pRequest As EnsLib.HL7.Message, Output pResponse As Ens.StringResponse) As %Status
{
	set sc = $$$OK
	
	try{
        if pRequest.DocType '= "" {
            $$$LOGINFO("namespace:"_$NAMESPACE)
            $$$LOGINFO("DocType:"_pRequest.DocType)
            set pResponse = ##class(Ens.StringResponse).%New()
            set IPP=pRequest.GetValueAt("PIDgrp.PID:PatientIDExternalID.ID")
            $$$LOGINFO("IPP:"_IPP)
            set patient=$CLASSMETHOD("APP.data.patient","getPatient",IPP)
            set patient.IPP=IPP
            set patient.lastName=pRequest.GetValueAt("PIDgrp.PID:PatientName.familyName")
            $$$LOGINFO("lastName:"_patient.lastName)
            set patient.firstName=pRequest.GetValueAt("PIDgrp.PID:PatientName.givenName")
            $$$LOGINFO("firstName:"_patient.firstName)
            // add the full HL7 message in patient HL7 messages array
            do patient.HL7.SetAt(pRequest.%ConstructClone(),patient.HL7.Count()+1)
            set sc=patient.%Save()
            if sc {
                set pResponse.StringValue = "successfully inserted in "_..ARCHIVAGE
                $$$LOGINFO(pResponse.StringValue)
            } else {
                set pResponse.StringValue = "ERROR WHILE INSERTING in "_..ARCHIVAGE_" ("_$system.Status.GetErrorText(sc)_")"
                $$$LOGWARNING(pResponse.StringValue)
            }
        } else {
            set pResponse.StringValue = "NO DOCTYPE DEFINED"
        }
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
	<MapItem MessageType="EnsLib.HL7.Message"> 
		<Method>HL7</Method>
	</MapItem>
</MapItems>
}

}
