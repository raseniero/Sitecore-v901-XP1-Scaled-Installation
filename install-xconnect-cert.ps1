#define parameters 
$prefix = "xconn" 
$PSScriptRoot = "C:\xp"
$Config = "$PSScriptRoot\config"
 
#install client certificate for xconnect 
$certParams = @{     
    Path = "$Config\xconnect-createcert.json"     
    CertificateName = "$prefix.xconnect_client" 
} 
Write-Host @solrParams
Install-SitecoreConfiguration @certParams -Verbose -WhatIf