echo "Temporarily adjusting the execution policy for installation..."
Set-Variable -Name "execution_policy" -Value (Get-ExecutionPolicy)
Set-ExecutionPolicy Bypass -Scope Process -Force
echo "Installing choclatey..."
#iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -Verbose:$false
echo "Enabling Hyper-V..."
#Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
echo "Installing VS2019, SSMS, OpenVPN, Office 2016, Slack, Docker"
#choco install visualstudio2019professional -y
#choco install sql-server-management-studio -y
#choco install openvpn -y
#choco install microsoft-office-deployment -y
#choco install slack
#choco install docker
#
echo "Resetting Execution Policy to previous value..."
Set-ExecutionPolicy -Scope Process $execution_policy
echo "Auto Setup Complete."
$Reboot = Read-Host -Prompt "A reboot is required restart now? (y/n)"
If ($Reboot -eq "y")
{
    Restart-Computer
}
Else
{
    echo "Don't forget to restart!"
}