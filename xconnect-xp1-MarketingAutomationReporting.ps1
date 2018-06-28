#define parameters 
$prefix = "xp" 
$PSScriptRoot = "C:\xp0901"
$XConnectCollectionService = "$prefix.xconnect" 
$sitecoreSiteName = "$prefix.sc"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr-6.6.2"

$SqlServer = "TABLET-THERJ67Q" 
$SqlAdminUser = "sa" 
$SqlAdminPassword="jajnav5@" 
  
#install sitecore instance 
$xconnectHostName = "$prefix.xconnect" 
$sitecoreParams = @{     
    Path = "$PSScriptRoot\config\xconnect-xp1-collection.json"     
    Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1collection.scwdp.zip"     
    LicenseFile = "$PSScriptRoot\license.xml"     
    SqlDbPrefix = $prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser     
    SqlAdminPassword = $SqlAdminPassword     
    SolrCorePrefix = $prefix  
    SolrUrl = $SolrUrl     
    XConnectCert = $certParams.CertificateName     
    Sitename = $sitecoreSiteName         
    XConnectCollectionService = "https://$XConnectCollectionService"    
} 
Write-Host @solrParams
Install-SitecoreConfiguration @sitecoreParams 