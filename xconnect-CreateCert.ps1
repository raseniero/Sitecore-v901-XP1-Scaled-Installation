#define parameters 
$Prefix = "xp901" 
$PSScriptRoot = "c:\xp"
$Config = "$PSScriptRoot\config"
 
#install client certificate for xconnect 
$XConnectCertParams = @{     
    Path = "$Config\xconnect-createcert.json"     
    CertificateName = "$Prefix.xconnect_client" 
    CertPath = "$PSScriptRoot"
} 
Write-Host @XConnectCertParams
Install-SitecoreConfiguration @XConnectCertParams -Verbose