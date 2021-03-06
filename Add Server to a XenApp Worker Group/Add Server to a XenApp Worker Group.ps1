﻿<# 
.SYNOPSIS
    Add the server to a XenApp Worker Group
.PARAMETER WorkerGroupName
   The name of the Worker Group
.PARAMETER ServerNames
   The name of the server to add to the Worker Group
#>

$ErrorActionPreference = "Stop"

If ( (Get-PSSnapin -Name Citrix.XenApp.Commands -ErrorAction SilentlyContinue) -eq $null )
{
    Try {
        Add-PsSnapin Citrix.XenApp.Commands
    } Catch {
        # capture any failure and display it in the error section, then end the script with a return
        # code of 1 so that CU sees that it was not successful.
        Write-Error "Not able to load the SnapIn" -ErrorAction Continue
        Write-Error $Error[1] -ErrorAction Continue
        Exit 1
    }
}

# This is the main function of the script, so we put it in try/catch so that any errors will be 
# handled in a ControlUp-friendly way.

Try {
    Add-XAWorkerGroupServer -WorkerGroupName $args[0] -ServerNames $args[1]
} Catch {
    # capture any failure and display it in the error section, then end the script with a return
    # code of 1 so that CU sees that it was not successful.
    Write-Error $Error[0] -ErrorAction Continue
    Exit 1
}

Write-Host "The operation completed successfully."


