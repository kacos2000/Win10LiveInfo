# Quick filter results from the 'Microsoft-Windows-BitLocker%4BitLocker Management.evtx' log

#Requires -RunAsAdministrator
cls
$OldFile = "$($env:WinDir).old\Windows\System32\winevt\Logs\Microsoft-Windows-BitLocker%4BitLocker Management.evtx"
$events =  try{Get-WinEvent -FilterHashtable @{Path = "$($OldFile)";ProviderName="Microsoft-Windows-BitLocker-API"} -ErrorAction SilentlyContinue|Where{$_.id -in (768,796,782,853)}}
           catch{$null}
if($events.Count -ge 1){Write-Output "Previous log found: $($OldFile)"}
$events += (Get-WinEvent -FilterHashtable @{ ProviderName="Microsoft-Windows-BitLocker-API"} -ErrorAction SilentlyContinue|Where{$_.id -in (768,796,782,853)})
Write-Output ""
Write-Output "ProviderName: Microsoft-Windows-BitLocker-API"
Write-Output ""
$events|sort -Property TimeCreated -Descending|Format-Table -AutoSize -Property Id,TimeCreated,Message