
$ExcelFile="D:\suguna\books.xlsx"
$sheetName = "Sheet1"
#Create an instance of Excel.Application and Open Excel file
$objExcel = New-Object -ComObject Excel.Application
$objworkbook = $objExcel.Workbooks.Open($ExcelFile)
$sheet = $workbook.Worksheets.Item($sheetName)
$objExcel.Visible=$false
$rowParameters,$colParameters = 1,2
$list = $sheet.Cells.Item($rowParameters+$i,$colParameters).text
$name = $sheet.Cells.Item($rowName+$i,$colName).text
$list