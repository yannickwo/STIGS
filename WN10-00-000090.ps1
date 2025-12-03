<#
.SYNOPSIS
    This PowerShell script Configure all passwords to expire.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#># -------------------------------------------------------------
# STIG Fix: Ensure all active local accounts require password expiration
# This clears "Password never expires" for all enabled local users.
# -------------------------------------------------------------

Write-Host "Applying STIG Fix: Enforcing password expiration on all active accounts..." -ForegroundColor Cyan

# Get all local users except system/service accounts
$Excluded = @("DefaultAccount", "WDAGUtilityAccount", "Guest", "Administrator")  # Modify list if needed

$Users = Get-LocalUser | Where-Object { 
    $_.Enabled -eq $true -and
    ($Excluded -notcontains $_.Name)
}

foreach ($user in $Users) {
    if ($user.PasswordExpires -eq $false) {
        Write-Host "Fixing: $($user.Name) — enabling password expiration..." -ForegroundColor Yellow
        Set-LocalUser -Name $user.Name -PasswordNeverExpires $false
    }
    else {
        Write-Host "Already compliant: $($user.Name)" -ForegroundColor Green
    }
}

Write-Host "Password expiration enforced for all active local accounts." -ForegroundColor Green
