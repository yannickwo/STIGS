<#
.SYNOPSIS
    This PowerShell script Uninstall "Simple TCPIP Services (i.e. echo, daytime etc)" from the system.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000110 

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
# STIG Fix: Uninstall Simple TCP/IP Services
# Feature name: SimpleTCP
# --------------------------------------------------------------

Write-Host "Checking for Simple TCP/IP Services installation..." -ForegroundColor Cyan

$feature = Get-WindowsOptionalFeature -Online -FeatureName SimpleTCP -ErrorAction SilentlyContinue

if ($null -ne $feature -and $feature.State -ne "Disabled") {
    Write-Host "Uninstalling Simple TCP/IP Services..." -ForegroundColor Yellow
    Disable-WindowsOptionalFeature -Online -FeatureName SimpleTCP -Remove -NoRestart
    Write-Host "Simple TCP/IP Services successfully removed." -ForegroundColor Green
}
else {
    Write-Host "Simple TCP/IP Services is not installed on this system." -ForegroundColor Gray
}

Write-Host "Process complete. A system restart is recommended." -ForegroundColor Green
