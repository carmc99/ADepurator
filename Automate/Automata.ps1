$ErrorActionPreference = "Continue"

<#
    AD functions
    validateExcludeUser: Valida si el usuario que se esta consultando se encuentra dentro de las excepciones.
    getExcludedUsers: Obtiene el archvio .json de los usuarios excluidos.
    searchForDelete: 

#>
function validateExcludeUser($userForValidate) {
    $usersExcluded = getExcludedUsers
    $file = [FileOutPut]::new()
    $bandera = $false 
    foreach ($user in $usersExcluded.users) {
        $out = 'Validating: ' + $userForValidate + ' With ' + $user
        Write-Host -ForegroundColor Green 'Validating: '  $userForValidate  ' With '  $user
        $file.exportLog($out) 
        if ($user -like $userForValidate) {
            $file.exportLog('Excluded: ' + $user) 
            return $false
        }
        else {
            $bandera = $true
        }
    }
    return $bandera
} 

function getExcludedUsers {
    return Get-Content -Raw -Path $PSScriptRoot\ExcludeUsers.json | ConvertFrom-Json
}

function searchForDelete() {
    $daysOfCreated = 120
    $daysLastLogon = 120
    $scopes = @('OU=test,DC=domain,DC=test,DC=co')		# Your OU's
    $properties = @('POBox', 'SamAccountName', 'CanonicalName', 'CN', 'DisplayName',
        'ObjectClass', 'HomePage', 'GivenName', 'DistinguishedName', 'EmailAddress', 
        'Description', 'City', 'Department', 'Country', 'LastLogonDate', 'Created', 'createTimeStamp', 'whenCreated')
    $users = @()
    Foreach ($scope in $scopes) {
        $users += Get-ADUser -Filter { (Enabled -eq $False) } -SearchScope Subtree -SearchBase $scope -Properties $properties | Where-Object { $_.LastLogonDate -le (Get-Date).AddDays(-$daysLastLogon) -and $_.whenCreated -le (Get-Date).AddDays(-$daysOfCreated) }
    }
    return $users
}

function searchForDisable() {
    $daysOfCreated = 90
    $daysLastLogon = 90
    $scopes = @('OU=test,DC=domain,DC=test,DC=co')
    $properties = @('POBox', 'SamAccountName', 'CanonicalName', 'CN', 'DisplayName',
        'ObjectClass', 'HomePage', 'GivenName', 'DistinguishedName', 'EmailAddress', 
        'Description', 'City', 'Department', 'Country', 'LastLogonDate', 'Created', 'createTimeStamp', 'whenCreated')
    $users = @()
    Foreach ($scope in $scopes) {
        $users += Get-ADUser -Filter { (Enabled -eq $True) } -SearchScope Subtree -SearchBase $scope -Properties $properties | Where-Object { $_.LastLogonDate -le (Get-Date).AddDays(-$daysLastLogon) -and $_.whenCreated -le (Get-Date).AddDays(-$daysOfCreated) }
    }
    return $users
}
function disable([string] $user) {
    $file = [FileOutPut]::new()
    try {
        Disable-ADAccount -Identity ($user)
        $out = 'Disabled: ' + $user
        Write-Host -ForegroundColor Yellow 'Disabled: ' $user
        $file.exportLog($out) 
    }
    catch {
        Write-Host $_ -ForegroundColor Red
        $file.exportLog($_) 
    }
}
function delete([string] $user) {
    $file = [FileOutPut]::new()
    try {
        Remove-ADUser $user -Confirm:$false
        $out = 'Deleted: ' + $user
        Write-Host -ForegroundColor Red 'Deleted: ' $user
        $file.exportLog($out) 
    }
    catch {
        Write-Host $_ -ForegroundColor Red
        $file.exportLog($_) 
    }
}

