# Get Current User's SHELL FOLDERS


$ShellFolders = @(
		"HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" # User/Roaming
		"HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" # User
		"HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" # Public
		"HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" # Public/Common
	)
	
	$shellf = Foreach ($ShellFolder in $ShellFolders)
	{
		
		$folders = Get-Item -Path $ShellFolder
		Foreach ($s in ($folders.GetValueNames() | sort))
		{
			if ($s -eq "!Do not use this registry key") { continue }
			$name = if ($s.StartsWith('{') -and ($s -in $Special.guid)) { $Special.where{ $_.guid -eq $s }.name }
			else { $s }
			
			[PSCustomObject]@{
				Key = Split-path $Folders.Name -NoQualifier
				Name = $Name
				Path = $Folders.GetValue($s)
			}
		}
	}
    $shellf |sort -property key,Name | format-table -GroupBy key -Property Name, Path