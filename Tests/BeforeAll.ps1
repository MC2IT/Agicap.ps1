using namespace System.Diagnostics.CodeAnalysis
using module ../Agicap.psd1

# The client identifier and secret.
$credential = [pscredential]::new($Env:AGICAP_CLIENT_ID, (ConvertTo-SecureString $Env:AGICAP_CLIENT_SECRET -AsPlainText))

# The client used to query the Agicap API.
[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "client")]
$client = New-AgicapClient $credential
