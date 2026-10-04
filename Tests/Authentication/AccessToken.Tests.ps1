<#
.SYNOPSIS
	Tests the features of the `Request-AccessToken` cmdlet.
#>
Describe "Request-AccessToken" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new access token" -Skip:($Env:CI -eq "true") {
		$scopes = "agicap:public-api", "public-api:manage-payment-beneficiaries", "public-api:manage-suppliers"
		$client.IsAuthenticated | Should-BeFalse

		$accessToken = Request-AgicapAccessToken $client $scopes
		$client.IsAuthenticated | Should-BeTrue
		$accessToken.HasExpired | Should-BeFalse
		$accessToken.Scopes | Should-BeCollection $scopes
		$accessToken.Type | Should-BeString Bearer -CaseSensitive
		$accessToken.Value | Should-MatchString "^[A-Z\d]{64,}" -CaseSensitive
	}

	It "should throw an exception when the credentials are invalid" {
		$client = New-AgicapClient ([pscredential]::new("FooBar", (ConvertTo-SecureString "BazQux" -AsPlainText)))
		{ Request-AgicapAccessToken $client -ErrorAction Stop } | Should-Throw
	}
}
