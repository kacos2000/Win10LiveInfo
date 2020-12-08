Clear-Host
	Write-Output ""
	Write-Output "Current User's Background activity Moderator (BAM) entries"
	Write-Output ""
    Write-Output "(Related source: https://github.com/kacos2000/Win10/blob/master/Bam/readme.md)"
    Write-Output ""
    Write-Output ""
	# SID of current user
	$sid = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).User.Value
	Write-Output "$($env:USERNAME) SID is $($sid)"
	Write-Output ""
	#  Get Bam entries for current user
	$bamKeys = @(
                "HKLM:\SYSTEM\CurrentControlSet\Services\bam\UserSettings\${Sid}",
                "HKLM:\SYSTEM\CurrentControlSet\Services\bam\state\UserSettings\${Sid}"
                )
    foreach($bamKey in $bamKeys){
       # Get entries from each key
		try
		{
			$Bam = Get-Item -Path $bamKey -ErrorAction SilentlyContinue
			#
			Write-Output "(Source $($bamKeys.indexof($bamKey) + 1): '$($bamKey)')"
			Write-Output "BAM Version $($bam.getvalue('Version'))"
			Write-Output "BAM Sequence Number $($bam.getvalue('SequenceNumber'))"
			Write-Output "Entries: $($Bam.ValueCount)"
			Write-Output ""
		}
		catch{continue}

$BamEntries = @()
$BamEntries += foreach($BamItem in $Bam.GetValueNames()){

            
         if($BamItem -notin ("Version","SequenceNumber")){
                $Hex = [System.BitConverter]::ToString($bam.getvalue($BamItem)[7..0]) -replace "-",""
                $TimeLocal = Get-Date ([DateTime]::FromFileTime([Convert]::ToInt64($Hex, 16))) -Format o
	            
                # https://github.com/libyal/winreg-kb/blob/master/documentation/Background%20Activity%20Moderator%20key.asciidoc
                $TypeH = [System.BitConverter]::ToString($bam.getvalue($BamItem)[19..16]) -replace "-",""
                $Type = [Convert]::ToInt64($TypeH, 16)
			    
                $d = if((((split-path -path $BamItem) | ConvertFrom-String -Delimiter "\\").P3)-match '\d{1}')
			    {((Split-path -path $BamItem).Remove(23)).Trimstart("\Device\HarddiskVolume")} else {$d = ""}

			    $f = if((((split-path -path $BamItem) | ConvertFrom-String -Delimiter "\\").P3)-match '\d{1}')
			    {Split-path -leaf ($BamItem).TrimStart()} else {$item}		

			    $cp = if((((split-path -path $BamItem) | ConvertFrom-String -Delimiter "\\").P3)-match '\d{1}')
			    {($BamItem).Remove(1,23)} else {$cp = ""}	
			    
               $bpath = if((((split-path -path $BamItem) | ConvertFrom-String -Delimiter "\\").P3)-match '\d{1}')
			    {"(Vol"+ $d+") "+$cp} else {$path = ""}
		
                [PSCustomObject]@{
						    LastRun     = $TimeLocal
						    Application = $f
                            Type        = $type
						    Full_Path   = if($type -eq 0){$bpath}elseif($type -eq 1){"-(UWP) " + $BamItem}else{$BamItem}
						#    Bam_Entry   = $BamItem
                } # end psobject
            } # End if 
        } # end foreach Item
      } # End foreach Key
$BamEntries|sort -Property LastRun -Descending|Format-Table -AutoSize -Wrap