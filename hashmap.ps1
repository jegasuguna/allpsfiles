<#
$csv = New-Object Collections.Generic.List[string]
$csv=Import-Csv -Path D:\suguna\Book1s.csv

$myHash = @{}
foreach($r in $csv)
{
    $myHash[$r.id]=$r.name

}#>


$filepath="D:\suguna\Book1s.csv"
$mytable = Import-Csv -Path $filePath
$hashTable=@{}
foreach($r in $mytable)
{
    $hashTable[$r.id]=$r.name
 
}

