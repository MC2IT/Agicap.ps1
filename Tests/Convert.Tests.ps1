using module ../Agicap.psd1

<#
.SYNOPSIS
	Tests the features of the `Convert` class.
#>
Describe "Convert" {
	Context "ToDateTime" {
		It "should convert the specified value to a [datetime] instance" -ForEach @(
			@{ Value = "2021-07-15"; Expected = Get-Date -Year 2021 -Month 7 -Day 15 -Hour 0 -Minute 0 -Second 0 }
			@{ Value = "2026-09-28T15:42:33+00:00"; Expected = Get-Date "2026-09-28T15:42:33+00:00" }
			@{ Value = [datetime]::Today; Expected = (Get-Date).Date }
		) {
			$dateTime = [Mc2it.Agicap.Convert]::ToDateTime($value)
			Should-HaveType ([datetime]) $dateTime
			Should-Be $expected.Year $dateTime.Year
			Should-Be $expected.Month $dateTime.Month
			Should-Be $expected.Day $dateTime.Day
			Should-Be $expected.Hour $dateTime.Hour
			Should-Be $expected.Minute $dateTime.Minute
			Should-Be $expected.Second $dateTime.Second
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, 123, "abc", @(), @{} {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToDateTime($_))
		}
	}

	Context "ToDecimal" {
		It "should convert the specified value to a decimal floating-point number" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToDecimal($_))
		}
	}

	Context "ToDictionary" {
		# TODO
	}

	Context "ToDouble" {
		It "should convert the specified value to a double-precision floating-point number" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToDouble($_))
		}
	}

	Context "ToEnum" {
		It "should convert the specified value to a enumerated value" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToEnum[DayOfWeek]($_))
		}
	}

	Context "ToGuid" {
		It "should convert the specified value to a [guid] instance" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToGuid($_))
		}
	}

	Context "ToInt32" {
		It "should convert the specified value to a 32-bit signed integer" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, 123.456, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::Toint32($_))
		}
	}

	Context "ToInt64" {
		It "should convert the specified value to a 64-bit signed integer" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, 123.456, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToInt64($_))
		}
	}

	Context "ToList" {
		# TODO
	}

	Context "ToString" {
		It "should convert the specified value to a string" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" {
			# TODO
		}
	}

	Context "ToUri" {
		It "should convert the specified value to a [uri] instance" {
			# TODO
		}

		It "should return `$null if the conversion is not supported" -ForEach $null, $true, "abc", @(), @{}, ([datetime]::Now) {
			Should-BeNull ([Mc2it.Agicap.Convert]::ToUri($_, [UriKind]::Absolute))
		}
	}
}
