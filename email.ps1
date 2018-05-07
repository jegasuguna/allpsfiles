[CmdletBinding(DefaultParameterSetName = 'Main')]
	param
	(
		[Parameter(ParameterSetName = 'Main',
				   Mandatory = $true)]
		[Alias('EmailTo')]
		[String[]]$To,
		
		[Parameter(ParameterSetName = 'Main',
				   Mandatory = $true)]
		[Alias('EmailFrom', 'FromAddress')]
		[String]$From,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[string]$FromDisplayName,
		
		[Parameter(ParameterSetName = 'Main')]
		[Alias('EmailCC')]
		[String]$CC,
		
		[Parameter(ParameterSetName = 'Main')]
		[Alias('EmailBCC')]
		[System.String]$BCC,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[Alias('ReplyTo')]
		[System.string[]]$ReplyToList,
		
		[Parameter(ParameterSetName = 'Main')]
		[System.String]$Subject = "Email from PowerShell",
		
		[Parameter(ParameterSetName = 'Main')]
		[System.String]$Body = "Hello World",
		
		[Parameter(ParameterSetName = 'Main')]
		[Switch]$BodyIsHTML = $false,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[System.Net.Mail.MailPriority]$Priority = "Normal",
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateSet("Default", "ASCII", "Unicode", "UTF7", "UTF8", "UTF32")]
		[System.String]$Encoding = "Default",
		
		[Parameter(ParameterSetName = 'Main')]
		[System.String]$Attachment,
		
		[Parameter(ParameterSetName = 'Main')]
		[System.Net.NetworkCredential]$Credential,
		
		[Parameter(ParameterSetName = 'Main',
				   Mandatory = $true)]
		
		[Alias("Server")]
		[string]$SMTPServer,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateRange(1, 65535)]
		[Alias("SMTPServerPort")]
		[int]$Port = 25,
		
		[Parameter(ParameterSetName = 'Main')]
		[Switch]$EnableSSL,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[Alias('EmailSender', 'Sender')]
		[string]$SenderAddress,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[System.String]$SenderDisplayName,
		
		[Parameter(ParameterSetName = 'Main')]
		[ValidateNotNullOrEmpty()]
		[Alias('DeliveryOptions')]
		[System.Net.Mail.DeliveryNotificationOptions]$DeliveryNotificationOptions
	)
	
	#PARAM
	
	PROCESS
	{
		TRY
		{
			# Create Mail Message Object
			$SMTPMessage = New-Object -TypeName System.Net.Mail.MailMessage
			$SMTPMessage.From = $From
			FOREACH ($ToAddress in $To) { $SMTPMessage.To.add($ToAddress) }
			$SMTPMessage.Body = $Body
			$SMTPMessage.IsBodyHtml = $BodyIsHTML
			$SMTPMessage.Subject = $Subject
			$SMTPMessage.BodyEncoding = $([System.Text.Encoding]::$Encoding)
			$SMTPMessage.SubjectEncoding = $([System.Text.Encoding]::$Encoding)
			$SMTPMessage.Priority = $Priority
			$SMTPMessage.Sender = $SenderAddress
			
			# Sender Displayname parameter
			IF ($PSBoundParameters['SenderDisplayName'])
			{
				$SMTPMessage.Sender.DisplayName = $SenderDisplayName
			}
			
			# From Displayname parameter
			IF ($PSBoundParameters['FromDisplayName'])
			{
				$SMTPMessage.From.DisplayName = $FromDisplayName
			}
			
			# CC Parameter
			IF ($PSBoundParameters['CC'])
			{
				$SMTPMessage.CC.Add($CC)
			}
			
			# BCC Parameter
			IF ($PSBoundParameters['BCC'])
			{
				$SMTPMessage.BCC.Add($BCC)
			}
			
			# ReplyToList Parameter
			IF ($PSBoundParameters['ReplyToList'])
			{
				foreach ($ReplyTo in $ReplyToList)
				{
					$SMTPMessage.ReplyToList.Add($ReplyTo)
				}
			}
			
			# Attachement Parameter
			IF ($PSBoundParameters['attachment'])
			{
				$SMTPattachment = New-Object -TypeName System.Net.Mail.Attachment($attachment)
				$SMTPMessage.Attachments.Add($STMPattachment)
			}
			
			# Delivery Options
			IF ($PSBoundParameters['DeliveryNotificationOptions'])
			{
				$SMTPMessage.DeliveryNotificationOptions = $DeliveryNotificationOptions
			}
			
			#Create SMTP Client Object
			$SMTPClient = New-Object -TypeName Net.Mail.SmtpClient
			$SMTPClient.Host = $SmtpServer
			$SMTPClient.Port = $Port
			
			# SSL Parameter
			IF ($PSBoundParameters['EnableSSL'])
			{
				$SMTPClient.EnableSsl = $true
			}
			
			# Credential Paramenter
			#IF (($PSBoundParameters['Username']) -and ($PSBoundParameters['Password']))
			IF ($PSBoundParameters['Credential'])
			{
				<#
				# Create Credential Object
				$Credentials = New-Object -TypeName System.Net.NetworkCredential
				$Credentials.UserName = $username.Split("@")[0]
				$Credentials.Password = $Password
				#>
				
				# Add the credentials object to the SMTPClient obj
				$SMTPClient.Credentials = $Credential
			}
			IF (-not $PSBoundParameters['Credential'])
			{
				# Use the current logged user credential
				$SMTPClient.UseDefaultCredentials = $true
			}
			
			# Send the Email
			$SMTPClient.Send($SMTPMessage)
			
		}#TRY
		CATCH
		{
			Write-Warning -message "[PROCESS] Something wrong happened"
			Write-Warning -Message $Error[0].Exception.Message
		}
	}#Process
	END
	{
		# Remove Variables
		Remove-Variable -Name SMTPClient -ErrorAction SilentlyContinue
		Remove-Variable -Name Password -ErrorAction SilentlyContinue
	}#END
