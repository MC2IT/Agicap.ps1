using namespace System.Diagnostics.CodeAnalysis
using module ../../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Entity` class.
#>
Describe "Entity" {
	BeforeAll {
		[SuppressMessage("PSUseDeclaredVarsMoreThanAssignments", "json")]
		$json = ConvertFrom-Json (Get-Content "$PSScriptRoot/../../Resources/Organizations/Entity.json" -Raw)
	}

	Context "FromPSObject" {
		It "should create an access token from the specified JSON payload" {
			$entity = [Mc2it.Agicap.Organizations.Entity] $json
			Should-BeString "FR" $entity.Country -CaseSensitive
			Should-Be 666 $entity.Id
			Should-BeString "My Entity" $entity.Name -CaseSensitive
		}
	}
}
