$table=Import-Csv -Path D:\suguna\Books.csv  -Header "Name","Parameters"
$Hash=@{}

<#foreach($list in $table)
{
$Hash[$list.Name] = $list.parameters
} #>

$list= $table.Parameters
$list


