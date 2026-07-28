using namespace System.Diagnostics.CodeAnalysis
using module ../Agicap.psd1

# The client identifier and secret.
$clientId = $Env:AGICAP_CLIENT_ID ?? "FooBar"
$clientSecret = ConvertTo-SecureString ($Env:AGICAP_CLIENT_SECRET ?? "BazQux") -AsPlainText

# The client used to query the Agicap API.
[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "client")]
$client = New-AgicapClient ([pscredential]::new($clientId, $clientSecret))

# The identifier of the test entity.
[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "entityId")]
$entityId = [int] ($Env:AGICAP_ENTITY ?? "000000")

# The identifier of the test entity.
[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "organizationId")]
$organizationId = [guid] ($Env:AGICAP_ORGANIZATION ?? "00000000-0000-0000-0000-000000000000")
