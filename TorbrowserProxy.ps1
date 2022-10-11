$RegistryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' 
$BypassAddresses = "*.ir;*.google.com;google.com;*.microsoft.com;github.com;<local>"
$TorProxyURI = "socks=127.0.0.1:9150"

$SystemProxy = Get-ItemProperty -Path $RegistryPath | Select-Object  ProxyEnable, ProxyServer, ProxyOverride

function SetTorProxy {
  Write-Debug "Applying Proxy Settings..."

  Set-ItemProperty -Path $RegistryPath -name ProxyEnable -Value 1  -Verbose
  Set-ItemProperty -Path $RegistryPath -name ProxyServer -Value $TorProxyURI -Verbose
  Set-ItemProperty -Path $RegistryPath -name ProxyOverride -Value $BypassAddresses -Verbose

  Write-Host -ForegroundColor Red "Proxy Applied!"
}
  

function ResetTorProxy {
  Write-Debug "Resetting Proxy Settings..."

  Set-ItemProperty -Path $RegistryPath -name ProxyServer -Value "" -Verbose
  Set-ItemProperty -Path $RegistryPath -name ProxyOverride -Value "" -Verbose
  Set-ItemProperty -Path $RegistryPath -name ProxyEnable -Value 0  -Verbose

  Write-Host -ForegroundColor Green "Proxy Reset Done!"
  
}

if ($SystemProxy.ProxyEnable) {
  
  if ($SystemProxy.ProxyServer -ne $TorProxyURI) {
    throw  "You Already Have A Proxy Setting, Please Check And Turn It OFF"
  }
  else
  { ResetTorProxy }

  [System.Environment]::Exit(0)
}

$TorStatus = Test-NetConnection -ComputerName 127.0.0.1 -Port 9150

if (!$TorStatus.TcpTestSucceeded) {
  throw "TorBrowser Not Running On Your System! Cannot Connect To 127.0.0.1:9150"
}

SetTorProxy
