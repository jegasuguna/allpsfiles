$t = Import-Csv -Path D:\suguna\Books.csv -Header "Name","Parameters"
$HashMap = @{}
foreach($r in $t)
{

	$HashMap[$r.Name] = $r.Parameters
   
}
 Write-Host $HashMap.Keys
  Write-Host $HashMap.Values

#Map{(Name, list()), (IT, List().....} 