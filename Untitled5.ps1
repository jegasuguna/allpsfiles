function Test-XmlFile
{
    <#
    .Synopsis
        Validates an xml file against an xml schema file.
    .Example
        PS> dir *.xml | Test-XmlFile schema.xsd
    #>
    #[CmdletBinding()]
    
    $XmlFile="D:\suguna\NewFile1.xml"
    $SchemaFile="D:\suguna\xmlSchema.xsd"

    begin {
        $schemaReader = New-Object System.Xml.XmlTextReader $SchemaFile
        $schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $ValidationEventHandler)
    }

    process {
        $ret = $true
        try {
            $xml = New-Object System.Xml.XmlDocument
            $xml.Schemas.Add($schema) | Out-Null
            $xml.Load($XmlFile)
            $xml.Validate({
                    throw ([PsCustomObject] @{
                        SchemaFile = $SchemaFile
                        XmlFile = $XmlFile
                        Exception = $args[1].Exception
                    })
                })
        } catch {
            Write-Error $_
            $ret = $false
        }
        $ret
    }

    end {
        $schemaReader.Close()
    }
}