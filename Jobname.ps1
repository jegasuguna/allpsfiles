#Set-ExecutionPolicy Unrestricted $objWorkbook = $objExcel.Workbooks.Open $Log_path"\ $Log_name"
$file = "D:\Suguna\Books.xlsx"
$sheetName = "Sheet1"
#Create an instance of Excel.Application and Open Excel file
$objExcel = New-Object -ComObject Excel.Application
$workbook = $objExcel.Workbooks.Open($file)
$sheet = $workbook.Worksheets.Item($sheetName)
$objExcel.Visible=$false
#Count max row

$rowMax = ($sheet.UsedRange.Rows).count
#Declare the starting positions
$rowName,$colName = 1,1
$rowParameters,$colParameters = 1,2
#loop to get values and store it
$name = $sheet.Cells.Item($rowName+$i,$colName).text
$parameters =@{}
function list 
{
for ($i=1; $i -le $rowMax-1; $i++)
{
$parameters = $sheet.Cells.Item($rowParameters+$i,$colParameters).text
}
Write-Host $parameters
}
list

#close excel file
$objExcel.quit()