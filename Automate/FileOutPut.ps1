
class FileOutPut {
    $path = 'C:\'  # Reports path
    $date
    $day
	$Time
	$Database

    FileOutPut() {
        $this.date = getActualDate
        $this.day = getActualDay
		$this.Time = New-Time
        $this.Database = New-Database
    }
    [void] exportToCsv($data, $operation) {
		$headers = @('CanonicalName', 'City', 'CN',	'Country', 'Created', 'createTimeStamp', 'Department', 'Description', 'DisplayName', 'DistinguishedName',	
		'EmailAddress',	'Enabled', 'GivenName', 'HomePage', 'LastLogonDate', 'Name', 'ObjectClass', 'ObjectGUID', 'POBox', 'SamAccountName',
		'SID', 'Surname', 'UserPrincipalName')
        $exportPath = $this.path + '\' + 'Report-' + $this.date + '.csv'
        if ($operation -eq 'delete') {
            $exportPath = $this.path + '\' + 'Deleted-' + $this.date + '.csv'
        }
        elseif ($operation -eq 'disable') {
            $exportPath = $this.path + '\' + 'Disabled-' + $this.date + '.csv'
        }
        $data | Select-Object $headers | Export-Csv $exportPath -NoTypeInformation -Append     
    }

    [void] exportLog($data) {
        $exportPath = $this.path + '\' + 'Log-' + $this.day + '.txt'
        $this.date + ' ' + $data | Out-File -FilePath $exportPath -Append
    }
}

function New-FileOutPut(){
	return [FileOutPut]::new()
}


<#
    $file = [FileOutPut]::new()
    $var = 'Prueba'
    $file.exportLog($var)
#>
