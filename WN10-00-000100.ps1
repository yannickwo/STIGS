<#
.SYNOPSIS
    This PowerShell script Uninstall "Internet Information Services" or "Internet Information Services Hostable Web Core" from the system.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000100

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
# STIG Fix: Uninstall IIS and IIS Hostable Web Core
# --------------------------------------------------------------

Write-Host "Checking for IIS components..." -ForegroundColor Cyan

# Function to disable a Windows Feature if installed
function Disable-FeatureIfPresent {
    param(
        [string]$FeatureName,
        [string]$DisplayName
    )

    $feature = Get-WindowsOptionalFeature -Online -FeatureName $FeatureName -ErrorAction SilentlyContinue

    if ($null -ne $feature -and $feature.State -ne "Disabled") {
        Write-Host "Uninstalling $DisplayName..." -ForegroundColor Yellow
        Disable-WindowsOptionalFeature -Online -FeatureName $FeatureName -Remove -NoRestart
        Write-Host "$DisplayName removed." -ForegroundColor Green
    }
    else {
        Write-Host "$DisplayName is not installed." -ForegroundColor Gray
    }
}

# IIS Server (full installation)
Disable-FeatureIfPresent -FeatureName "IIS-WebServerRole" -DisplayName "Internet Information Services (IIS)"

# IIS Hostable Web Core
Disable-FeatureIfPresent -FeatureName "IIS-WebServerManagementTools" -DisplayName "IIS Management Tools"
Disable-FeatureIfPresent -FeatureName "IIS-WebServer" -DisplayName "IIS Web Server"
Disable-FeatureIfPresent -FeatureName "IIS-HostableWebCore" -DisplayName "IIS Hostable Web Core"

# Workstation variants (IIS legacy components)
Disable-FeatureIfPresent -FeatureName "IIS-WebServerRole" -DisplayName "IIS Web Server Role"
Disable-FeatureIfPresent -FeatureName "IIS-WebServer" -DisplayName "IIS Web Server Core"

Write-Host "IIS removal process completed. A reboot is recommended." -ForegroundColor Green
