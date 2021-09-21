Class INTEROP.msg.detailPatientsResponse Extends Ens.Response
{

Property patients As array Of INTEROP.struct.patient;

Storage Default
{
<Data name="patients">
<Attribute>patients</Attribute>
<Structure>subnode</Structure>
<Subscript>"INTEROP.msg.detailPatientsResponse.patients"</Subscript>
</Data>
<Type>%Storage.Persistent</Type>
}

}
