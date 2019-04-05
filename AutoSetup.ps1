echo "Temporarily adjusting the execution policy for installation..."
Set-Variable -Name "execution_policy" -Value (Get-ExecutionPolicy)
Set-ExecutionPolicy Bypass -Scope Process -Force
echo "Installing choclatey..."
#iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -Verbose:$false
echo "Installing VS2019, SSMS, OpenVPN, Office 2016"
#choco install visualstudio2019professional -y
#choco install sql-server-management-studio -y
#choco install openvpn -y
#choco install microsoft-office-deployment -y
echo "Resetting Execution Policy to previous value..."
Set-ExecutionPolicy -Scope Process $execution_policy
echo "Auto Setup Complete."