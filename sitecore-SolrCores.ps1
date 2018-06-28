#define parameters 
$Prefix = "xp901" 
$PSScriptRoot = "c:\xp"
$Config = "$PSScriptRoot\config"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 
  
#install solr cores for sitecore 
$SitecoreSolrParams = @{     
    Path = "$Config\sitecore-solr.json"     
    SolrUrl = $SolrUrl     
    SolrRoot = $SolrRoot     
    SolrService = $SolrService     
    CorePrefix = $Prefix 
} 
Write-Host @SitecoreSolrParams
Install-SitecoreConfiguration @SitecoreSolrParams -Verbose