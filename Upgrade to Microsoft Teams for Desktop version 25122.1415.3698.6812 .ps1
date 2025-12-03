<#
.SYNOPSIS
    This PowerShell script Upgrade to Microsoft Teams for Desktop version 25122.1415.3698.6812.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : CVE-2025-53783
    Plugin IDs      : ID 250276
    STIG-ID         : N/A

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#># ------------------------------------------------------------
# Upgrade Microsoft Teams (MS Store version)
# Target version: 25122.1415.3698.6812 or later
# ------------------------------------------------------------

$RequiredVersion = [Version]"25122.1415.3698.6812"
$TeamsPackageID = "Microsoft.Teams"

Write-Host "Checking Microsoft Teams installation..." -ForegroundColor Cyan

# Refresh winget sources (includes Microsoft Store source)
Write-Host "Refreshing Winget sources..."
winget source update

# Check installed Teams
$Installed = winget list --id $TeamsPackageID --source msstore | Select-Object -Skip 1

if ($Installed) {
    # Extract version
    $InstalledVersionString = ($Installed -split '\s+')[-1]
    
    try {
        $InstalledVersion = [Version]$InstalledVersionString
    }
    catch {
        Write-Host "Unable to parse installed version. Proceeding with upgrade."
        $InstalledVersion = [Version]"0.0.0.0"
    }

    Write-Host "Installed version: $InstalledVersion"
    Write-Host "Required version:  $RequiredVersion"

    if ($InstalledVersion -lt $RequiredVersion) {
        Write-Host "Upgrading Microsoft Teams..." -ForegroundColor Yellow
        winget upgrade --id $TeamsPackageID --source msstore --accept-source-agreements --accept-package-agreements
    }
    else {
        Write-Host "Microsoft Teams is already up to date." -ForegroundColor Green
    }
}
else {
    Write-Host "Microsoft Teams is not installed. Installing now..." -ForegroundColor Yellow
    winget install --id $TeamsPackageID --source msstore --accept-source-agreements --accept-package-agreements
}

Write-Host "Completed." -ForegroundColor Green
