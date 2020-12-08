    Write-Output ""
	Write-Output "SEARCH/CORTANA AppCache*.txt files - SEARCH MRU"
	Write-Output "Collects recent apps & Jumplists from AppCache**.txt files"
    Write-Output "from the Cortana/Search App folders in Current User's Profile (& Windows.old if it exists)"
    Write-Output ""
    Write-Output ""
    Write-Output "(Related info: https://github.com/kacos2000/Win10/blob/master/Cortana/readme.md)"
    Write-Output ""
	
	$Folders = [System.Collections.ArrayList]@()
	if (test-path  "$($env:LOCALAPPDATA)\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	{
		[Void]$Folders.Add("$($env:LOCALAPPDATA)\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	}
	if (test-path  "$($env:LOCALAPPDATA)\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	{
		[Void]$Folders.Add("$($env:LOCALAPPDATA)\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	}
	
	if (test-path  "$($env:WinDir).old\Users\$($env:USERNAME)\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	{
		[Void]$Folders.Add("$($env:WinDir).old\Users\$($env:USERNAME)\AppData\Local\Packages\Microsoft.Windows.Cortana_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	}
	if (test-path  "$($env:WinDir).old\Users\$($env:USERNAME)\AppData\Local\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	{
		[Void]$Folders.Add("$($env:WinDir).old\Users\$($env:USERNAME)\AppData\Local\Packages\Microsoft.Windows.Search_cw5n1h2txyewy\LocalState\DeviceSearchCache\")
	}
	if ($Folders.Count -lt 1) { Continue }
	
	Write-Output ""
	Write-Output "Searching Folder(s): "
	$Folders | Format-List
	Write-Output ""
	
	$AppcacheFiles = @()
	$AppcacheFiles += Foreach ($Folder in $Folders)
	{
		# Get AppCache files
		Get-ChildItem $Folder -Filter AppCache*.txt -Force -ErrorAction SilentlyContinue
	}
	
	if ($AppcacheFiles.Count -lt 1) { Write-warning "No 'AppCache**.txt' files found"; Exit }
	[void][System.Text.Encoding]::utf8
	Write-Output "Files found: $($AppcacheFiles.Count)"
	Write-Output $AppcacheFiles.name
	
	# Read the files
	$Apps = @()
	
	$Apps = Foreach ($Appcache in $AppcacheFiles)
	{
		#(Get-Content $Appcache.fullname -encoding utf8 | Out-String | ConvertFrom-Json)
		$read = New-Object System.IO.StreamReader($Appcache.fullname)
		($read.ReadToEnd() | Out-String | ConvertFrom-Json)
		$read.Close()
		$read.Dispose()
	}
	$list = foreach ($app in $apps)
	{
		$dateaccessed = if (![string]::IsNullOrEmpty($app.'System.DateAccessed'.Value) -and
			$app.'System.DateAccessed'.Value -ne 0)
		{
			[datetime]::FromFileTime([bigint]($app.'System.DateAccessed'.Value))
		}
		else { $null }
		
		[pscustomobject]@{
			DateAccessed = if (![string]::IsNullOrEmpty($dateaccessed)) { Get-Date $dateaccessed -f s }else{ $null }
			Application_Name = $app.'System.ItemNameDisplay'.value
			FileName		 = $app.'System.FileName'.Value
			TimesUsed	     = $app.'System.Software.TimesUsed'.Value
			PackageFullName  = $app.'System.AppUserModel.PackageFullName'.value
			PackageType	     = $app.'System.AppUserModel.PackageFullName'.type
			ItemType		 = $app.'System.ItemType'.Value
			Identity		 = $app.'System.Identity'.Value
			ProductVersion   = $app.'System.Software.ProductVersion'.Value
			ParsingName	     = $ParsingName
			JumplistType	 = $app.'System.ConnectedSearch.JumpList'.Type
		}
		
	}
	
	#$list|sort -Property DateAccessed -Descending | Format-Table -Property ItemNameDisplay,DateAccessed,TimesUsed,Path,Description -AutoSize -Wrap
	
	Write-Output ""
	Write-Output "RECENT APPS LIST:"
	Write-Output ""
	
	$list | sort -Property DateAccessed -Descending -Unique | Format-Table -Property Application_Name, DateAccessed, TimesUsed -AutoSize -Wrap
	
	# Jumplist (Recent & Pinned Items)
	
	$jumplist = foreach ($app in $apps)
	{
		
		# Replace known folder GUID with it's Name
		$ParsingName = $app.'System.ParsingName'.Value
		foreach ($i in $known.Keys) { $ParsingName = $ParsingName -replace "{$($i)}", $known[$i] }
		
		if ($app.'System.ConnectedSearch.JumpList'.Value -ne "[]" -and (ConvertFrom-Json($app.'System.ConnectedSearch.JumpList'.Value)).$jumpitems.count -ge 1)
		{
			
			foreach ($jumpitem in (ConvertFrom-Json($app.'System.ConnectedSearch.JumpList'.Value)).items)
			{
				
				$types = @{
					2 = "Tasks/Top Sites";
					1 = "Frequent"
				}
				
				[pscustomobject]@{
					App = $app.'System.ItemNameDisplay'.value
					Type = $types[$jumpitem.Type] + " ($($jumpitem.Type))"
					ParsingName = $ParsingName
					Name = $jumpitem.Name
					Description = $jumpitem.Description
					Path = $jumpitem.Path
				}
			}
		}
		else { continue }
	}
	Write-Output ""
	Write-Output "JUMPLIST:"
	Write-Output ""
	$jumplist | Sort -property Path | Format-Table -GroupBy App -Property Name, Type, Path -AutoSize -Wrap
	Write-Output ""