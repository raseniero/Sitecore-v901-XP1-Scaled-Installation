#define parameters 
$Prefix = "xp" 
$PSScriptRoot = "c:\xp"

$ConfigPath = "$PSScriptRoot\config"
$CertificateName = "$Prefix.xconnect_client" 
$SitecoreSiteName = "$Prefix.sc" 

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 

$SqlServer = "RAMONASENIE0E1F" 
$SqlAdminUser = "sa" 
$SqlAdminPassword="jajnav5@" 
  
#install sitecore instance 
$XConnectHostName = "$Prefix.xconnect" 
$SitecoreParams = @{     
    Path = "$ConfigPath\xconnect-xp1-collection.json"     
    Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1collection.scwdp.zip"     
    LicenseFile = "$PSScriptRoot\license.xml"     
    SqlDbPrefix = $Prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser     
    SqlAdminPassword = $SqlAdminPassword     
    SolrCorePrefix = $Prefix  
    SolrUrl = $SolrUrl     
    XConnectCert = $CertificateName     
    Sitename = $SitecoreSiteName         
    XConnectCollectionService = "https://$XConnectCollectionService"    
} 
Write-Host @SitecoreParams
Install-SitecoreConfiguration @SitecoreParams 