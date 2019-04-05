$Iteration = -1
$PercentDone = 0
function DisplayProgress($message)
{
    $global:Iteration++
    $global:PercentDone = ($global:Iteration / 10 * 100)
    Write-Progress -Activity 'Running AutoSetup' -Status $message -PercentComplete $global:PercentDone
}
DisplayProgress("Temporarily adjusting the execution policy for installation")
$ExecPolicy = (Get-ExecutionPolicy)
Set-ExecutionPolicy Bypass -Scope Process -Force
Start-Sleep 1
DisplayProgress("Installing choclatey")
Start-Sleep 1
#iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -Verbose:$false
DisplayProgress("Enabling Hyper-V")
Start-Sleep 1
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart
DisplayProgress("Installing Visual Studio 2019 Professional")
Start-Sleep 1
#choco install visualstudio2019professional -y
DisplayProgress("Installing SQL Server Management Studio")
Start-Sleep 1
#choco install sql-server-management-studio -y
DisplayProgress("Installing OpenVPN")
Start-Sleep 1
#choco install openvpn -y
DisplayProgress("Installing Microsoft Office 2016")
Start-Sleep 1
#choco install microsoft-office-deployment -y
DisplayProgress("Installing Slack")
Start-Sleep 1
#choco install slack
DisplayProgress("Installing Docker")
Start-Sleep 1
#choco install docker
DisplayProgress("Resetting Execution Policy to previous value")
Set-ExecutionPolicy -Scope Process $ExecPolicy
Start-Sleep 1
Write-Output "Auto Setup Complete."
$Reboot = Read-Host -Prompt "A reboot is required restart now? (y/n)"
If ($Reboot -eq "y")
{
    Restart-Computer
}
Else
{
    Write-Output "Don't forget to restart!"
}
Remove-Variable Iteration
Remove-Variable PercentDone