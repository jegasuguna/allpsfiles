function Do-Something
{
    throw "bad"
}

#Write-Error -Message "Houston, we have a problem." -ErrorAction Stop

<#try
{
    Do-Something
}
catch
{
    Write-Output "Something threw an exception"
}

try
{
    Do-Something -ErrorAction Stop
}
catch
{
    Write-Output "Something threw an exception or used Write-Error"
}
#>
$PSItem.Exception.Message