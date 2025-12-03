<#
.SYNOPSIS
    This PowerShell script Configure the policy value for Computer Configuration >> Administrative Templates >> MS Security Guide >> "Configure SMBv1 Server" to "Disabled".

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : CVE-2013-3900
    Plugin IDs      : N/A
    STIG-ID         : <#
.SYNOPSIS
    This PowerShell script EnableCertPaddingCheck (32-bit & 64-bit).

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000165

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#># -------------------------------------------------------------------
# STIG Fix: Disable SMBv1 Server
# This replicates the GPO "Configure SMBv1 Server" = "Disabled"
# Registry path used by MS Security Guide policy
# -------------------------------------------------------------------

Write-Host "Applying STIG fix: Disable SMBv1 Server..." -ForegroundColor Cyan

# Registry path used by SecGuide.admx policy
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$ValueName = "SMB1"

# Create registry key if missing
if (!(Test-Path $RegPath)) {
    Write-Host "Registry path missing. Creating..." -ForegroundColor Yellow
    New-Item -Path $RegPath -Force | Out-Null
}

# Apply STIG value
Write-Host "Setting SMB1 Server to Disabled..." -ForegroundColor Yellow
New-ItemProperty -Path $RegPath -Name $ValueName -Value 0 -PropertyType DWORD -Force | Out-Null

# Optional additional hardening:
# Disable Windows Optional Feature "SMB1Protocol"
Write-Host "Disabling SMB1 Windows Feature (if present)..." -ForegroundColor Yellow
Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol -NoRestart -ErrorAction SilentlyContinue

Write-Host "SMBv1 Server is now disabled per STIG requirements." -ForegroundColor Green
Write-Host "A system restart is required for the change to fully take effect." -ForegroundColor Yellow
