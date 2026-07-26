using module PSScriptAnalyzer

"Performing the static analysis of source code..."
$PSScriptRoot, "Sources", "Tests" | Invoke-ScriptAnalyzer -ExcludeRule PSAvoidUsingConvertToSecureStringWithPlainText -Recurse
Test-ModuleManifest Agicap.psd1 | Out-Null
