#Globals
$Iteration = -1
$PercentDone = 0

#Progress Bar
function DisplayProgress($message)
{
    $global:Iteration++
    $global:PercentDone = ($global:Iteration / 11 * 100)
    Write-Progress -Activity 'Running AutoSetup' -Status $message -PercentComplete $global:PercentDone
}

#Execution policy adjust is required to install choclatey
DisplayProgress("Temporarily adjusting the execution policy for installation")
$ExecPolicy = (Get-ExecutionPolicy)
Set-ExecutionPolicy Bypass -Scope Process -Force

#Intstall software
DisplayProgress("Installing choclatey")
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) > logfile.txt
DisplayProgress("Enabling Hyper-V")
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All -NoRestart >> logfile.txt
DisplayProgress("Installing Visual Studio 2019 Professional")
choco install visualstudio2019professional -y >> logfile.txt
DisplayProgress("Installing SQL Server Management Studio")
choco install sql-server-management-studio -y >> logfile.txt
DisplayProgress("Installing OpenVPN")
choco install openvpn -y >> logfile.txt
DisplayProgress("Installing Microsoft Office 2016")
choco install microsoft-office-deployment -y >> logfile.txt
DisplayProgress("Installing Slack")
choco install slack >> logfile.txt
DisplayProgress("Installing Docker")
choco install docker >> logfile.txt

#Return execution policy to original state
DisplayProgress("Resetting Execution Policy to previous value")
Set-ExecutionPolicy -Scope Process $ExecPolicy

#Clean up globals
DisplayProgress("Cleaning up")
Remove-Variable Iteration
Remove-Variable PercentDone
Remove-Variable ExecPolicy
Start-Sleep 1

#Finish and prompt for restart
Write-Output "Auto Setup Complete."
Write-Output "Check logfile.txt for a complete log of installation."
$Reboot = Read-Host -Prompt "A restart is required. Restart now? (y/n)"
If ($Reboot -eq "y")
{
    Restart-Computer
}
Else
{
    Write-Output "Don't forget to restart!"
}
