	Write-Output "INSTALLED SOFTWARE"
	Write-Output ""
	Write-Output "Source 1 = HKLM:\Software\microsoft\windows\currentversion\uninstall\"
	Write-Output "Source 2 = HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\"
    Write-Output "Source 3 - HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\"
	# Parsing BOTH registry keys:
	$unin = @()
	try   { $unin = Get-itemproperty -path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName,DisplayVersion,InstallDate -Wait }
	catch { [void][System.Windows.Forms.MessageBox]::Show($WinLiveInfo, "It appears there was an Error", "Win10LiveInfo", "OK", "Warning"); $unin = $null }
	try   { $unin += Get-ItemProperty -path "HKLM:\Software\microsoft\windows\currentversion\uninstall\*" | Select-Object DisplayName,DisplayVersion,InstallDate -Wait }
	catch { [void][System.Windows.Forms.MessageBox]::Show($WinLiveInfo, "It appears there was an Error", "Win10LiveInfo", "OK", "Warning"); $null }
    try   { $unin += Get-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*" | Select-Object DisplayName,DisplayVersion,InstallDate -Wait }
	catch { [void][System.Windows.Forms.MessageBox]::Show($WinLiveInfo, "It appears there was an Error", "Win10LiveInfo", "OK", "Warning"); $null }
	if ($unin.count -ge 1)
	{
		$uninsoft = foreach ($un in $unin)
		{
			$InstallDate = if (![string]::IsNullOrEmpty($un.InstallDate) -and $un.InstallDate.length -eq 8 ){
                            try  {Get-Date([DateTime]::ParseExact($un.InstallDate, "yyyyMMdd",$null)) -f s}
                            catch{$un.InstallDate}
                            }
                            elseif(![string]::IsNullOrEmpty($un.InstallDate) -and $un.InstallDate.length -eq 10){
                            try  {Get-date (Get-Date 01.01.1970).AddSeconds($un.InstallDate) -f s}
                            catch{try{Get-Date([DateTime]::ParseExact($un.InstallDate, "MM/dd/yyyy",$null)) -f s}
                                  catch{$un.InstallDate}
                                 }
                            }
                            else{$null}
                
                [PSCustomObject]@{
					DisplayName = "$($un.displayname) (v.$($un.displayversion))"
					InstallDate = $InstallDate
				}
			}
		}
		$uninsoft | sort -Property InstallDate -Descending -Unique | format-table -AutoSize -wrap

	Write-Output ""