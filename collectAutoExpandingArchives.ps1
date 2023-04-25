[array]$output = @()
[array]$uniqueOutput = @()
$functionObject = $NULL

$mailboxes = get-mailbox -resultsize unlimited 

foreach ($mailbox in $mailboxes)
{
	write-host "Testing mailbox:"
	write-host $mailbox.externalDirectoryObjectID

	$locations = @(get-mailboxLocation -user $mailbox.ExternalDirectoryObjectId -MailboxLocationType AuxArchive)

    if ($locations.count -gt 0)
    {
        write-host "Aux archive found."

			$functionObject = New-Object PSObject -Property @{
                    ExternalDirectoryObjectID = $mailbox.externalDirectoryObjectID  
			        PrimarySMTPAddress = $mailbox.primarySMTPAddress
                    LocationCount = $locations.count
                }

		    $output += $functionObject
    }
}

$uniqueOutput = $output | Sort-Object -Property PrimarySMTPAddress -Unique