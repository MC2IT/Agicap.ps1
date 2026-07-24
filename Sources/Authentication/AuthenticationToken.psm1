<#
.SYNOPSIS
	Represents an OAuth token and its metadata.
#>
class AuthenticationToken {

	<#
	.SYNOPSIS
		The time when the provided token expires.
	#>
	[datetime] $ExpiresOn = (Get-Date)

	<#
	.SYNOPSIS
		The OAuth scopes.
	#>
	[ValidateNotNull()]
	[string[]] $Scopes = @()

	<#
	.SYNOPSIS
		The token type.
	#>
	[ValidateNotNullOrWhiteSpace()]
	[string] $Type = "Bearer"

	<#
	.SYNOPSIS
		The token value.
	#>
	[securestring] $Value

	<#
	.SYNOPSIS
		Gets a value indicating whether this token has expired.
	.OUTPUTS
		`$true` if this token has expired, otherwise `$false`.
	#>
	[bool] HasExpired() {
		return $this.ExpiresOn -le (Get-Date)
	}

	<#
	.SYNOPSIS
		Creates a new access token from the specified JSON entity.
	.PARAMETER Object
		The JSON entity.
	.OUTPUTS
		The access token corresponding to the specified JSON entity.
	#>
	static [AuthenticationToken] op_Explicit([psobject] $Object) {
		return [AuthenticationToken]@{
			ExpiresOn = (Get-Date).AddSeconds($Object.expires_in ?? 0)
			Scopes = $Object.scope ? -split $Object.scope : @()
			Type = $Object.token_type ?? "Bearer"
			Value = ConvertTo-SecureString ($Object.access_token ?? "") -AsPlainText
		}
	}
}
