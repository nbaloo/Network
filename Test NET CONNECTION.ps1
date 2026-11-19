#VARIABLES **************************************************************************************

$port = 443

$Ips = @(
    "login.xdr.trendmicro.com",
    "portal.eu.xdr.trendmicro.com",
    '3.125.197.162',
    "63.184.155.110",
    "63.188.39.62",
    "52.29.81.133",
    "3.123.146.181",
    "63.188.6.181",
    "52.57.247.90",
    "63.183.101.16",
    '63.183.173.70',
    '18.197.222.228', 
    '18.199.28.33'
    "18.197.39.255"
)

#DEBUT DU SCRIPT **************************************************************************************

  Write-Host -ForegroundColor Cyan "Test débuté à :" (Get-Date).DateTime

    Write-Host ""
    Write-Host ("{0,-35} {1,-18} {2}" -f "IP - port $port", "TcpTestSucceeded", "Warning") 
    Write-Host ("-" * 110)

    foreach ($IP in $IPs) {
        $Warnings = @()

        $Test = Test-NetConnection -ComputerName $IP -Port $port `
            -WarningVariable Warnings `
            -WarningAction SilentlyContinue

        Write-Host ("{0,-35} {1,-18} {2}" -f `
            $IP, $Test.TcpTestSucceeded, ($Warnings -join ' | '))
    }

# LIGNE COPIER COLLER pour ANALYSE FORTIANALYSER **************************************************************************************

    Write-Host "`n--- FORTIANALYZER, SOURCE IP ---" -ForegroundColor Cyan
    (Test-NetConnection -ComputerName "1.1.1.1" -Port 1 -WarningAction SilentlyContinue ).SourceAddress.IPAddress

    Write-Host "`n--- FORTIANALYZER, DESTINATION IP ---" -ForegroundColor Cyan
    $FortiIPs = $IPs | Where-Object {
        $_ -match '^\d{1,3}(\.\d{1,3}){3}$'
    }
    $FortiIPs -join ',' 
