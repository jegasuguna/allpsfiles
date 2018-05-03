$csv="D:\suguna\books.csv"
$importTable = @()
$data = import-csv -path $csv

foreach($item in $data){

    $hash = @{
       Name=$item.Name
       Param1=$item.Parameters
    Param2=$item.grade
    }
    $objTemp = new-object psobject -property $hash
    $importTable += $objTemp
}


$importTable