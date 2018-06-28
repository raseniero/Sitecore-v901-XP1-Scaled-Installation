#define parameters 
$Prefix = "xp901" 
$PSScriptRoot = "c:\xp"
$ConfigPath = "$PSScriptRoot\config"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 
 
#install solr cores for xdb 
$XConnectSolrParams = @{     
    Path = "$ConfigPath\xconnect-solr.json"     
    SolrUrl = $SolrUrl     
    SolrRoot = $SolrRoot     
    SolrService = $SolrService     
    CorePrefix = $Prefix 
} 
Write-Host @XConnectSolrParams
Install-SitecoreConfiguration @XConnectSolrParams -Verbose