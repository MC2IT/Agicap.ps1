using namespace System.Diagnostics.CodeAnalysis
using module ../Agicap.psd1

# The client identifier and secret.
$clientId = $Env:AGICAP_CLIENT_ID ?? "FooBar"
$clientSecret = ConvertTo-SecureString ($Env:AGICAP_CLIENT_SECRET ?? "BazQux") -AsPlainText

# The client used to query the Agicap API.
[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "client")]
$client = New-AgicapClient ([pscredential]::new($clientId, $clientSecret))
