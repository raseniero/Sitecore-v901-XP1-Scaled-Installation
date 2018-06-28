#define parameters 
$prefix = "xp" 
$PSScriptRoot = "C:\xp"
$Config = "$PSScriptRoot\config"
 
#install client certificate for xconnect 
$certParams = @{     
    Path = "$Config\xconnect-createcert.json"     
    CertificateName = "$prefix.xconnect_client" 
    CertPath = "$PSScriptRoot"
} 
Write-Host @solrParams
Install-SitecoreConfiguration @certParams -Verbose