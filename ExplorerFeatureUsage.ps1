﻿Write-Output ""
Write-Output "EXPLORER FEATURE USAGE"
Write-Output ""
Write-Output "(Related Tweet: https://twitter.com/sv2hui/status/1174311913083330560?s=20)"
Write-Output "(Related Blog Post: https://www.group-ib.com/blog/featureusage)"
Write-Output ""

$known = @{
            "308046B0AF4A39CB" = "Mozilla Firefox 64bit";
            "E7CF176E110C211B" = "Mozilla Firefox 32bit";
            "DE61D971-5EBC-4F02-A3A9-6C82895E5C04" = "AddNewPrograms";
            "724EF170-A42D-4FEF-9F26-B60E846FBA4F" = "AdminTools";
            "A520A1A4-1780-4FF6-BD18-167343C5AF16" = "AppDataLow";
            "A305CE99-F527-492B-8B1A-7E76FA98D6E4" = "AppUpdates";
            "9E52AB10-F80D-49DF-ACB8-4330F5687855" = "CDBurning";
            "DF7266AC-9274-4867-8D55-3BD661DE872D" = "ChangeRemovePrograms";
            "D0384E7D-BAC3-4797-8F14-CBA229B392B5" = "CommonAdminTools";
            "C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D" = "CommonOEMLinks";
            "0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8" = "CommonPrograms";
            "A4115719-D62E-491D-AA7C-E74B8BE3B067" = "CommonStartMenu";
            "82A5EA35-D9CD-47C5-9629-E15D2F714E6E" = "CommonStartup";
            "B94237E7-57AC-4347-9151-B08C6C32D1F7" = "CommonTemplates";
            "0AC0837C-BBF8-452A-850D-79D08E667CA7" = "Computer";
            "4BFEFB45-347D-4006-A5BE-AC0CB0567192" = "Conflict";
            "6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD" = "Connections";
            "56784854-C6CB-462B-8169-88E350ACB882" = "Contacts";
            "82A74AEB-AEB4-465C-A014-D097EE346D63" = "ControlPanel";
            "2B0F765D-C0E9-4171-908E-08A611B84FF6" = "Cookies";
            "B4BFCC3A-DB2C-424C-B029-7FE99A87C641" = "Desktop";
            "FDD39AD0-238F-46AF-ADB4-6C85480369C7" = "Documents";
            "374DE290-123F-4565-9164-39C4925E467B" = "Downloads";
            "1777F761-68AD-4D8A-87BD-30B759FA33DD" = "Favorites";
            "FD228CB7-AE11-4AE3-864C-16F3910AB8FE" = "Fonts";
            "CAC52C1A-B53D-4EDC-92D7-6B2E8AC19434" = "Games";
            "054FAE61-4DD8-4787-80B6-090220C4B700" = "GameTasks";
            "D9DC8A3B-B784-432E-A781-5A1130A75963" = "History";
            "4D9F7874-4E0C-4904-967B-40B0D20C3E4B" = "Internet";
            "352481E8-33BE-4251-BA85-6007CAEDCF9D" = "InternetCache";
            "BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968" = "Links";
            "F1B32785-6FBA-4FCF-9D55-7B8E7F157091" = "LocalAppData";
            "2A00375E-224C-49DE-B8D1-440DF7EF3DDC" = "LocalizedResourcesDir";
            "4BD8D571-6D19-48D3-BE97-422220080E43" = "Music";
            "C5ABBF53-E17F-4121-8900-86626FC2C973" = "NetHood";
            "D20BEEC4-5CA8-4905-AE3B-BF251EA09B53" = "Network";
            "2C36C0AA-5812-4B87-BFD0-4CD0DFB19B39" = "OriginalImages";
            "69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C" = "PhotoAlbums";
            "33E28130-4E1E-4676-835A-98395C3BC3BB" = "Pictures";
            "DE92C1C7-837F-4F69-A3BB-86E631204A23" = "Playlists";
            "76FC4E2D-D6AD-4519-A663-37BD56068185" = "Printers";
            "9274BD8D-CFD1-41C3-B35E-B13F55A758F4" = "PrintHood";
            "5E6C858F-0E22-4760-9AFE-EA3317B67173" = "Profile";
            "62AB5D82-FDC1-4DC3-A9DD-070D1D495D97" = "ProgramData";
            "905E63B6-C1BF-494E-B29C-65B732D3D21A" = "ProgramFiles";
            "F7F1ED05-9F6D-47A2-AAAE-29D317C6F066" = "ProgramFilesCommon";
            "6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D" = "ProgramFilesCommonX64";
            "DE974D24-D9C6-4D3E-BF91-F4455120B917" = "ProgramFilesCommonX86";
            "6D809377-6AF0-444B-8957-A3773F02200E" = "ProgramFilesX64";
            "7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E" = "ProgramFilesX86";
            "A77F5D77-2E2B-44C3-A6A2-ABA601054A51" = "Programs";
            "DFDF76A2-C82A-4D63-906A-5644AC457385" = "Public";
            "C4AA340D-F20F-4863-AFEF-F87EF2E6BA25" = "PublicDesktop";
            "ED4824AF-DCE4-45A8-81E2-FC7965083634" = "PublicDocuments";
            "3D644C9B-1FB8-4F30-9B45-F670235F79C0" = "PublicDownloads";
            "DEBF2536-E1A8-4C59-B6A2-414586476AEA" = "PublicGameTasks";
            "3214FAB5-9757-4298-BB61-92A9DEAA44FF" = "PublicMusic";
            "B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5" = "PublicPictures";
            "2400183A-6185-49FB-A2D8-4A392A602BA3" = "PublicVideos";
            "52A4F021-7B75-48A9-9F6B-4B87A210BC8F" = "QuickLaunch";
            "AE50C081-EBD2-438A-8655-8A092E34987A" = "Recent";
            "BD85E001-112E-431E-983B-7B15AC09FFF1" = "RecordedTV";
            "B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC" = "RecycleBin";
            "8AD10C31-2ADB-4296-A8F7-E4701232C972" = "ResourceDir";
            "3EB685DB-65F9-4CF6-A03A-E3EF65729F3D" = "RoamingAppData";
            "B250C668-F57D-4EE1-A63C-290EE7D1AA1F" = "SampleMusic";
            "C4900540-2379-4C75-844B-64E6FAF8716B" = "SamplePictures";
            "15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5" = "SamplePlaylists";
            "859EAD94-2E85-48AD-A71A-0969CB56A6CD" = "SampleVideos";
            "4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4" = "SavedGames";
            "7D1D3A04-DEBB-4115-95CF-2F29DA2920DA" = "SavedSearches";
            "EE32E446-31CA-4ABA-814F-A5EBD2FD6D5E" = "SEARCH_CSC";
            "98EC0E18-2098-4D44-8644-66979315A281" = "SEARCH_MAPI";
            "190337D1-B8CA-4121-A639-6D472D16972A" = "SearchHome";
            "8983036C-27C0-404B-8F08-102D10DCFD74" = "SendTo";
            "7B396E54-9EC5-4300-BE0A-2482EBAE1A26" = "SidebarDefaultParts";
            "A75D362E-50FC-4FB7-AC2C-A8BEAA314493" = "SidebarParts";
            "625B53C3-AB48-4EC1-BA1F-A1EF4146FC19" = "StartMenu";
            "B97D20BB-F46A-4C97-BA10-5E3608430854" = "Startup";
            "43668BF8-C14E-49B2-97C9-747784D784B7" = "SyncManager";
            "289A9A43-BE44-4057-A41B-587A76D7E7F9" = "SyncResults";
            "0F214138-B1D3-4A90-BBA9-27CBC0C5389A" = "SyncSetup";
            "1AC14E77-02E7-4E5D-B744-2EB1AE5198B7" = "System";
            "D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27" = "SystemX86";
            "A63293E8-664E-48DB-A079-DF759E0509F7" = "Templates";
            "5B3749AD-B49F-49C1-83EB-15370FBD4882" = "TreeProperties";
            "0762D272-C50A-4BB0-A382-697DCD729B80" = "UserProfiles";
            "F3CE0F7C-4901-4ACC-8648-D5D44B04EF8F" = "UserFiles";
            "18989B1D-99B5-455B-841C-AB7C74E4DDFC" = "Videos";
            "F38BF404-1D43-42F2-9305-67DE0B28FC23" = "Windows"
            }          
$Launch = Get-Item -Path "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppLaunch"       -ErrorAction SilentlyContinue
$Jump = Get-Item -Path "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched"       -ErrorAction SilentlyContinue
$Show = Get-Item -Path "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView"      -ErrorAction SilentlyContinue
$tray = Get-Item -Path "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\TrayButtonClicked" -ErrorAction SilentlyContinue
#
Write-Output ""
Write-Output "Source: 'HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\TrayButtonClicked'"
Write-Output "(Nr.of clicks on Task Bar items)"
Write-Output ""
# AppLaunch
$tray  = Foreach($b in $tray.property){
        [PSCustomObject]@{
                Button  = $b
                Clicked = $tray.GetValue($b)
                }
}
$tray|sort -Property Clicked -Descending|Format-Table -Property Clicked, Button -AutoSize -Wrap
Write-Output ""
#
Write-Output "Source: 'HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched'"
Write-Output "(Nr. of times Pinned Taskbar Applications were launched)"
Write-Output ""
# AppLaunch
$AppLaunch  = Foreach($l in $Launch.property){
                $LAppname = $l
                foreach ($o in $known.Keys) {
                               $LAppname = $LAppname -replace $o, $known[$o]
                               }
        [PSCustomObject]@{
                Application = $LAppname
                Launched    = $launch.GetValue($l)
                }
}
$AppLaunch|sort -Property Launched -Descending|Format-Table -Property Launched, Application -AutoSize -Wrap
Write-Output ""
#
Write-Output "Source: 'HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched'"
Write-Output "(..left clicks on Task Bar applications..to switch from one to another..)"
Write-Output ""
# AppSwitched
$AppSwitched  = Foreach($J in $Jump.property){
                $Appname = $j
                foreach ($i in $known.Keys) {
                               $AppName = $AppName -replace $i, $known[$i]
                               }
        [PSCustomObject]@{
                Application = $Appname
                Switched    = $jump.GetValue($j)
                }
}
$AppSwitched|sort -Property Switched -Descending|Format-Table -Property Switched, Application -AutoSize -Wrap
Write-Output ""
# ShowJumpView
Write-Output "Source: 'HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView'"
Write-Output "(..right clicks on Task Bar applications..to check or open recent files..)"
Write-Output ""
$ShowJumpView  = Foreach($s in $show.property){
                $ShowAppname = $s
                foreach ($k in $known.Keys) {
                               $ShowAppname = $ShowAppname -replace $k, $known[$k]
                               }
        [PSCustomObject]@{
                Application = $ShowAppname
                Viewed      = $show.GetValue($s)
                }
}
$ShowJumpView|sort -Property Viewed -Descending|Format-Table -Property Viewed, Application -AutoSize -Wrap
Write-Output ""