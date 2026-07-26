using namespace System.Diagnostics.CodeAnalysis
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `BadRequest` class.
#>
Describe "BadRequest" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../../Resources/Authentication/BadRequest.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create a bad request from the specified JSON payload" {
			$badRequest = [Mc2it.Agicap.Authentication.BadRequest] $json
			Should-BeString "An error occurred." $badRequest.Error -CaseSensitive
		}
	}
}
