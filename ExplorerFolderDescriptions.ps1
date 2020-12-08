# Gets the GUID & Description for 'Known' User Folders

$Descriptions = Get-ChildItem -path "HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions"

# https://github.com/microsoft/Windows-classic-samples/blob/master/Samples/Win7Samples/winui/shell/appplatform/knownfolders/kfdef.reg
#
# Category can be one of four possible values:
#  KF_CATEGORY_VIRTUAL	= 0x1
#  KF_CATEGORY_FIXED	= 0x2
#  KF_CATEGORY_COMMON	= 0x3
#  KF_CATEGORY_PERUSER	= 0x4

$category = @{
    "1" = "Virtual";
    "2" = "Fixed";
    "3" = "Common";
    "4" = "Per User"}

    $Special = foreach ($Des in $Descriptions)
	{
        $cat = $des.GetValue("Category")

		[PSCustomObject]@{
			
			GUID = split-path $des.Name -Leaf
			Name = $des.GetValue("Name")
			RelativePath = $des.GetValue("RelativePath")
			Category = $category["$($cat)"]
		}
	}
	$Special | sort -Property Category, Name | Format-Table -AutoSize

