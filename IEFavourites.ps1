$fav = get-childitem -path "$([System.Environment]::GetFolderPath('Favorites'))" -Filter *.url -Recurse -ErrorAction SilentlyContinue

$urls = foreach($url in $fav){
        
        $urlcontent = [System.IO.File]::ReadAllLines($url.FullName)

        $i=0
        ForEach ($line in $urlcontent) {
        if($line.StartsWith("URL=")){$OrigURL = $urlcontent[$i].trimstart("*URL=").trim() }
        if($line.StartsWith("IconFile=")){$IconFile = $urlcontent[$i].trimstart("*IconFile=").trim() }
        if($line.StartsWith("IconIndex=")){$IconIndex = $urlcontent[$i].trimstart("*IconIndex=").trim() }
        $i++
        }
        [PSCustomObject]@{
                IconFile = $IconFile
                IconIdx  = $IconIndex
                URL      = $OrigURL
                }
}
$urls|Format-Table -AutoSize -Wrap 