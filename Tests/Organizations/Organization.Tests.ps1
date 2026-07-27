using namespace System.Diagnostics.CodeAnalysis
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Organization` class.
#>
Describe "Organization" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../../Resources/Organizations/Organization.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create an access token from the specified JSON payload" {
			$organization = [Mc2it.Agicap.Organizations.Organization] $json
			Should-Be ([guid]::new("3ebb0163-6ac8-449d-a34b-496244f380a1")) $organization.Id
			Should-BeString "My Company" $organization.Name -CaseSensitive
		}
	}
}
