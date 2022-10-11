# TorBrowser-ProxyWindows
Simple PowerShell Script That Proxy Your Windows Into TorBrowser Easily.

## Before You Start
1. Make sure your TorBrowser is running and connected.
2. If you already have some proxy settings in your system, please clear them.
3. If your system proxied by this script, SECOND RUNNING, will restore all changes to defaults. 

## Running
```powershell
  git clone https://github.com/MasoudAbdaal/TorBrowser-ProxyWindows.git
  cd .\TorBrowser-ProxyWindows\
  Set-ExecutionPolicy Bypass
  .\TorbrowserProxy.ps1
```