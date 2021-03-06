$path-"D:\suguna\Book1s.csv"
Import-Csv-Path $path | ForEach-Object-begin
 {
#define an empty hash table
$hash=@{}
} 
-process 
{
<# if there is a type column, then add the entry as that type otherwise we'll treat it as a string #>
if ($_.Type)
 {
$type=[type]"$($_.type)"
}
else {
$type=[type]"string"
}
Write-Verbose "Adding $($_.key)"
Write-Verbose "Setting type to $type"

$hash.Add($_.Key,($($_.Value)-as $type))

} -end {
#write hash to the pipeline
Write-Output $hash
}