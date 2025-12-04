<#
.SYNOPSIS
    This PowerShell script Uninstall "Telnet Client" from the system.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-04
    Last Modified   : 2024-12-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000115 

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
# STIG Fix: Uninstall Telnet Client
# Windows Optional Feature name: TelnetClient
# --------------------------------------------------------------

Write-Host "Checking for Telnet Client installation..." -ForegroundColor Cyan

$feature = Get-WindowsOptionalFeature -Online -FeatureName TelnetClient -ErrorAction SilentlyContinue

if ($null -ne $feature -and $feature.State -ne "Disabled") {
    Write-Host "Uninstalling Telnet Client..." -ForegroundColor Yellow
    Disable-WindowsOptionalFeature -Online -FeatureName TelnetClient -Remove -NoRestart
    Write-Host "Telnet Client successfully removed." -ForegroundColor Green
}
else {
    Write-Host "Telnet Client is not installed on this system." -ForegroundColor Gray
}

Write-Host "Process complete. A system restart is recommended." -ForegroundColor Green
