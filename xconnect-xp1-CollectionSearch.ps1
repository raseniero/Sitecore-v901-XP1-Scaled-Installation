#define parameters 
$Prefix = "xp" 
$PSScriptRoot = "c:\xp"
$ConfigPath = "$PSScriptRoot\config"

$XConnectCollectionService = "$Prefix.xconnect" 
$SitecoreSiteName = "$Prefix.sc"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 

$SqlServer = "RAMONASENIE0E1F" 
$SqlAdminUser = "sa" 
$SqlAdminPassword="jajnav5@" 
  
#install sitecore instance 
$xconnectHostName = "$Prefix.xconnect" 
$sitecoreParams = @{     
    Path = "$PSScriptRoot\config\xconnect-xp1-collectionsearch.json"     
    Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1collectionsearch.scwdp.zip"     
    LicenseFile = "$PSScriptRoot\license.xml"     
    SqlDbPrefix = $Prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser     
    SqlAdminPassword = $SqlAdminPassword     
    SolrCorePrefix = $Prefix  
    SolrUrl = $SolrUrl     
    XConnectCert = $certParams.CertificateName     
    Sitename = $SitecoreSiteName         
    XConnectCollectionService = "https://$XConnectCollectionService"    
} 
Write-Host @solrParams
Install-SitecoreConfiguration @sitecoreParams 