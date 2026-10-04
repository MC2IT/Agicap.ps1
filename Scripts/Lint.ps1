using module PSScriptAnalyzer
using module ./Cmdlets.psm1

"Performing the static analysis of source code..."
Invoke-FSharpLint Agicap.slnx -Configuration Configuration/FSharpLint.json
$PSScriptRoot, "Sources", "Tests" | Invoke-ScriptAnalyzer -ExcludeRule PSAvoidUsingConvertToSecureStringWithPlainText -Recurse
Test-ModuleManifest Agicap.psd1 | Out-Null
