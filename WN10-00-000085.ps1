<#
.SYNOPSIS
    This PowerShell script Limit local user accounts on domain-joined systems. Remove any unauthorized local accounts.

.NOTES
    Author          : Yannick Wona
    LinkedIn        : linkedin.com/in/yanne-k-3bb065b9/
    GitHub          : github.com/yannickwo
    Date Created    : 2024-12-03
    Last Modified   : 2024-12-03
    Version         : 1.0
    CVEs            : CVE-2013-3900
    Plugin IDs      : N/A
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
#># -------------------------------------------------------------
# STIG Fix: Limit Local User Accounts on Domain-Joined Systems
# Removes unauthorized local accounts safely
# -------------------------------------------------------------

Write-Host "Checking local accounts on domain-joined system..." -ForegroundColor Cyan

# Built-in accounts that must NOT be removed
$ProtectedAccounts = @(
    "Administrator",
    "DefaultAccount",
    "Guest",
    "WDAGUtilityAccount",
    "sshd"  # if present
)

# ------------------------------------------
# MODIFY THIS LIST for allowed local accounts
# ------------------------------------------
$AllowedLocalAccounts = @(
    "Administrator",      # default built-in admin
    "LocalAdmin",         # <-- example (replace/remove)
    "HelpDeskSupport"     # <-- example (replace/remove)
)

# Combine protected + allowed accounts (never remove)
$DoNotRemove = $ProtectedAccounts + $AllowedLocalAccounts

# Get all local users
$LocalUsers = Get-LocalUser

foreach ($user in $LocalUsers) {
    $UserName = $user.Name

    if ($DoNotRemove -contains $UserName) {
        Write-Host "Keeping allowed account: $UserName" -ForegroundColor Green
    }
    else {
        Write-Host "Removing unauthorized local account: $UserName" -ForegroundColor Yellow
        
        # Disable before deletion for safety
        Disable-LocalUser -Name $UserName -ErrorAction SilentlyContinue

        # Remove the account
        Remove-LocalUser -Name $UserName -ErrorAction SilentlyContinue

        Write-Host "Account removed: $UserName" -ForegroundColor Red
    }
}

Write-Host "Local account cleanup completed." -ForegroundColor Green
