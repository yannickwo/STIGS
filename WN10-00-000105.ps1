<#
.SYNOPSIS
    This PowerShell script Uninstall "Simple Network Management Protocol (SNMP)" from the system.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            :  N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000105

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#># --------------------------------------------------------------
# STIG Fix: Uninstall Simple Network Management Protocol (SNMP)
# --------------------------------------------------------------

Write-Host "Checking for SNMP installation..." -ForegroundColor Cyan

$feature = Get-WindowsOptionalFeature -Online -FeatureName SNMP -ErrorAction SilentlyContinue

if ($null -ne $feature -and $feature.State -ne "Disabled") {
    Write-Host "Uninstalling SNMP..." -ForegroundColor Yellow
    Disable-WindowsOptionalFeature -Online -FeatureName SNMP -Remove -NoRestart
    Write-Host "SNMP successfully removed." -ForegroundColor Green
}
else {
    Write-Host "SNMP is not installed on this system." -ForegroundColor Gray
}

Write-Host "SNMP removal process complete. A system restart is recommended." -ForegroundColor Green
