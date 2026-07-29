<#
.SYNOPSIS
	Tests the features of the `Request-AccessToken` cmdlet.
#>
Describe "Request-AccessToken" {
	BeforeAll { . "$PSScriptRoot/../BeforeAll.ps1" }

	It "should return a new access token" -Skip:($Env:CI -eq "true") {
		$scopes = [Mc2it.Agicap.Authentication.Scopes]::All
		Should-BeFalse $client.IsAuthenticated

		$accessToken = Request-AgicapAccessToken $client $scopes
		Should-BeTrue $client.IsAuthenticated
		Should-BeFalse $accessToken.HasExpired
		Should-BeCollection $scopes $accessToken.Scopes
		Should-BeString Bearer $accessToken.Type -CaseSensitive
		Should-MatchString "^[A-Z\d]{64,}" $accessToken.Value -CaseSensitive
	}

	It "should throw an exception when the credentials are invalid" {
		$client = New-AgicapClient ([pscredential]::new("FooBar", (ConvertTo-SecureString "BazQux" -AsPlainText)))
		Should-Throw -ScriptBlock { Request-AgicapAccessToken $client -ErrorAction Stop }
	}
}
