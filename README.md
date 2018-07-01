# Sitecore XP1 Scaled (On-Premise) Installation Notes

This is a guide or a reference for installing Sitecore XP1 v9.0 in a fully scaled on-premise environment.

>Note: This documentation is still a **work-in-progress**, do expect constant updates. For questions or need elaboration please send an email to *rasenieroAtGmailDotCom*.

## Getting Started

These instructions will serve as a guide or a reference for deploying Sitecore XP1 v9.0 in a fully scaled on-premise environment. 

In the following scenario below, every core roles and XP service roles is performed by a dedicated server. This is a pre-built topology and is also known as XP1 Scaled. However, roles can be combine into a single instance, e.g. all xConnect and xDB roles (i.e. Collection, Collection Search, Marketing Automation, Marketing Automation Reporting, and ReferenceData) can be installed in a single instance. 

We will be referencing *the diagram* below in our instructions to come.

![fully-scaled-simple1](https://user-images.githubusercontent.com/2329372/42052718-721db50a-7ac4-11e8-8709-abb304179e2c.png)

## Prerequisites

Depending on the role or instance, each has it's own respective prerequisites, but the *general prerequisites* are enumerated below.

* Microsoft Windows Server 2016
* Microsoft SQL Server 2016 SP1 with SQL Management Studio 2017 for Database server
* IIS 10 for Web server
* .NET Framework 4.6.2 or later
* PowerShell 5.1 or later
* Sitecore Installation Framework (SIF) PowerShell module
* Any Web Browsers in this list: Microsoft Internet Explorer 11, Mozilla Firefox, Google Chrome or Microsoft Edge 

For the Hardware requirements, please refer to the Sitecore 9.0 Installation Guide. 

For each role or instance in *the diagram*, find their respective prerequesites below.

### Solr Instance

* Solr 6.6.2
* Chocolatey 0.10.11
* Java/JRE 1.8 (installed using Chocolatey)
* NSSM 2.24 (installed using Chocolatey)
* OpenSSL.Light 1.1.0 (installed using Chocolatey)

To setup *Solr* instance see section [Installation->Solr Instance](README.md#solr-instance-installation)

### All Other Instances

This includes *XConnect*, *xDB Services*, *Content Management*, *Content Delivery*, *Processing* and *Reporting* instances.

* Refer to the *general prerequisites* for applicable prerequisites
* Add IIS role with IIS Management Console feature
* Add .Net Extensibility 4.6 feature, under Web Server (IIS)->Web Server->Application Development
```
PS C:\>Install-WindowsFeatures Web-Asp-Net45
```
* Microsoft Visual C++ 2015 Redistributable (vc_redist.x64.exe)
* Web Platform Installer 5.0 (WebPlatformInstaller_amd64_en-US.msi)
* Web Deploy 3.6 for Hosting Servers using Web Platform Installer
* UrlRewrite2.exe (URLRewrite2) using Web Platform Installer
* Microsoft SQL Server Data-Tier Application Framework (DacFx) version 2016 (DacFramework-x64.msi)
* SQLSysClrTypes.msi 
* SQLCMD using Powershell below
```
PS C:\> Install-Module -name SqlServer
```
or
```
PS C:\> Install-Module -name Sqlps
```

## Installation 

The general approach is to start with setting up *Solr* instance then followed by *XConnect (i.e. Collection, CollectionSearch roles)*, *xDB Services (i.e. ReferenceData, MarketingAutomationReporting, MarketingAutomation roles)*, *Reporting*, *Processing*, *Content Management*, and *Content Delivery* instances.

### General Installation

This applies to the follwing instances or roles *XConnect*, *xDB Services*, *Content Management*, *Content Delivery*, *Processing* and *Reporting* instances.

1. Clone this repository into an *Installation Directory*.
> Note: In this scenario is c:\xp, you can also use other location i.e. d:\xp but need to update the scripts.
2. Download and extract *Sitecore 9.0.1 rev. 171219 (WDP XP1 packages).zip* to the *Installation Directory*. 
> Note: All  WDP Packages (*.zip files) should be directly under the *Installation Directory*.
3. Save you Sitecore license file directly under the *Installation Directory* as *license.xml*.
4. Set NETWORK SERVICE with Modify permission to c:\inetpub\wwwroot folder
5. Set IIS_IUSRS with Modify permission to %WINDIR%\temp\ folder
6. Set IIS_IUSRS with Modify permission to %WINDIR%\Globalization\ folder
7. Set IIS_IUSRS with Modify permission to %PROGRAMDATA%\Microsoft\Crypto\ folder 
8. Clear the Web Platform Installer download cache
9. Enable *contained database authentication* by running a sql query below
```
sp_configure 'contained database authentication', 1; GO RECONFIGURE; GO
```

### Solr Instance Installation

1. Install Chocolatey by runnning the PowerShell script below as Administrator.
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```
2. Install NSSM using Chocolatey by running the command below.
```
C:\> choco install nssm
```
3. Install JRE 1.8 using Chocolatey by running the command below.
```
C:\> choco install jre8
```
4. Install OpenSSL using Chocolatey by running the command below.
```
C:\> choco install openssl.light
```
5. Download and install Solr 6.2.2 by following the [Installing Solr](https://lucene.apache.org/solr/guide/6_6/installing-solr.html) guide.
6. Enable SSL on Solr by following the [Enabling SSL](https://lucene.apache.org/solr/guide/6_6/enabling-ssl.html) guide.
7. Setup as a Service using NSSM
8. To install the Sitecore Solr Cores, edit the parameters on the [c:\xp\sitecore-SolrCores.ps1](sitecore-SolrCores.ps1) scripts to match local values.
```
#define parameters 
$Prefix = "xp901" 
$PSScriptRoot = "c:\xp"
$Path = "$PSScriptRoot\config\sitecore-solr.json"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 
$CorePrefix = $Prefix
```
9. Run c:\xp\sitecore-SolrCores.ps1 <<Press Enter>>
```
PS C:\> .\sitecore-SolrCores.ps1 scripts
```
>Note: If the cores exist, they will be overwritten.
10. To install the xConnect Solr Cores, edit the parameters on the [c:\xp\xconnect-SolrCores.ps1](xconnect-SolrCores.ps1) scripts to match local values. 
```
#define parameters 
$Prefix = "xp901" 
$PSScriptRoot = "c:\xp"
$ConfigPath = "$PSScriptRoot\config"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662"
```
11. Run c:\xp\xconnect-SolrCores.ps1 scripts. 
```
PS C:\> .\xconnect-SolrCores.ps1 <<Press Enter>>
```
>Note: If the cores exist, they will be overwritten.

### xConnect Instance Installation

1. To install the xConnect Collection role, edit the parameters for [c:\xp\xconnect-xp1-Collection.ps1](xconnect-xp1-Collection.ps1), they are exposed so its easy to change them for production environment purposes.
```
<#
Exposed parameters for creating the Collection Service, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.

$Path = "$PSScriptRoot\config\xconnect-xp1-collection.json"
$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1collection.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.collection" 

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default (for development environment purposes) but for production it's recommended to be change.
#>
$SqlDbPrefix = $Prefix
$SqlAdminUser = "sa" 
$SqlAdminPassword="Test12345" 
$SqlCollectionUser = "collectionuser"
$SqlCollectionPassword = "Test12345"
$SqlProcessingPoolsUser = "poolsuser"
$SqlProcessingPoolsPassword = "Test12345"
$SqlMarketingAutomationUser = "marketingautomationuser"
$SqlMarketingAutomationPassword = "Test12345"
$SqlMessagingUser = "messaginguser"
$SqlMessagingPassword = "Test12345"
$SqlServer = "RAMONASENIE0E1F" 

$XConnectEnvironment ="Development" #For production environment use Production
$XConnectLogLevel = "Information" #Can be Debug
```
2. Run c:\xp\xconnect-xp1-Collection.ps1. 
```
PS C:\xp> .\xconnect-xp1-Collection.ps1 <<Press Enter>>
```
>Note: you can pass -Verbose or -WhatIf parameters to see more information or run the script without making actual changes.

>Note: The script will take about (+/-) 1 minute and 40 seconds to complete execution, see the [xconnect-xp1-collection.log](xconnect-xp1-collection.log) file.
3. To install the xConnect Collection Search role, edit the parameters for [c:\xp\xconnect-xp1-CollectionSearch.ps1](xconnect-xp1-CollectionSearch.ps1) script.
```
<#
Exposed parameters for creating the Collection Search Service, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, 
if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\xconnect-xp1-collectionsearch.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1collectionsearch.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.collectionsearch" 

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), 
if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. 
The rest can use the default (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlCollectionUser = "collectionuser"
$SqlCollectionPassword = "Test12345"
$SqlProcessingPoolsUser = "poolsuser"
$SqlProcessingPoolsPassword = "Test12345"
$SqlMarketingAutomationUser = "marketingautomationuser"
$SqlMarketingAutomationPassword = "Test12345"
$SqlMessagingUser = "messaginguser"
$SqlMessagingPassword = "Test12345"
$SqlServer = "RAMONASENIE0E1F" 

$SolrCorePrefix = $Prefix
$SolrUrl = "https://localhost:8983/solr" #Change to reflect the production Solr Url

$XConnectEnvironment ="Development" #For production environment use Production
$XConnectLogLevel = "Information" #Use Debug for Development
```
>Note: There are not $SqlAdminUser and $SqlAdminPassword parameters but $SolrUrl and $SolrCorePrefix has been added.
4. Run c:\xp\xconnect-xp1-CollectionSearch.ps1. 
```
PS C:\xp> .\xconnect-xp1-CollectionSearch.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 11 minutes to complete execution, 
see the [xconnect-xp1-collectionsearch.log](xconnect-xp1-collectionsearch.log) file.

### xDB Services Instance Installation

1. To install xDB Marketing Automation role, edit [c:\xp\xconnect-xp1-MarketingAutomation.ps1](xconnect-xp1-MarketingAutomation.ps1) scripts to reflect local settings. 
```
<#
Exposed parameters for creating the xDB Marketing Automation role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\xconnect-xp1-MarketingAutomation.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1marketingautomation.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.marketingautomation" 

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlAdminUser = "sa"
$SqlAdminPassword = "Test12345"
$SqlServer = "RAMONASENIE0E1F"
$SqlCollectionUser = "collectionuser"
$SqlCollectionPassword = "Test12345"
$SqlProcessingPoolsUser = "poolsuser"
$SqlProcessingPoolsPassword = "Test12345"
$SqlMarketingAutomationUser = "marketingautomationuser"
$SqlMarketingAutomationPassword = "Test12345"
$SqlMessagingUser = "messaginguser"
$SqlMessagingPassword = "Test12345" 

$XConnectCollectionService = "https://XConnectCollection" #Keep this default value unless you know what you're doing
$XConnectReferenceDataService = "https://XConnectReferenceData" #Keep this default value unless you know what you're doing
$XConnectEnvironment ="Development" #For production environment use Production
$XConnectLogLevel = "Information" #Use Debug for Development
```
>Note: In comparison to xconnect-xp1-Collection-Search.ps1, the $SqlAdminUser, $SqlAdminPassword, XConnectCollectionService and XConnectReferenceDataService has been added to the parameters.
2. Execute c:\xp\xconnect-xp1-MarketingAutomation.ps1 scripts.
```
PS C:\xp> .\xconnect-xp1-MarketingAutomation.ps1 <<Press Enter>>
```
>Note: If the script fails on the first run and you need to rerun it, perform an iisreset in the terminal.
```
PS C:\> iisreset
```
>Note: The script will take about (+/-) 9 seconds to complete execution, see the [xconnect-xp1-MarketingAutomation.log](xconnect-xp1-MarketingAutomation.log) file.
3. To install xDB Marketing Automation Reporting role, edit the [c:\xp\xconnect-xp1-MarketingAutomationReporting.ps1](xconnect-xp1-MarketingAutomationReporting.ps1) scripts to reflect local settings.
```
<#
Exposed parameters for creating the xDB Marketing Automation Reporting role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\xconnect-xp1-MarketingAutomationReporting.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1marketingautomationreporting.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.marketingautomationreporting" 

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlReferenceDataUser = "referencedatauser"
$SqlReferenceDataPassword = "Test12345"
$SqlMarketingAutomationUser = "marketingautomationuser"
$SqlMarketingAutomationPassword = "Test12345"

$XConnectEnvironment ="Development" #For production environment use Production
$XConnectLogLevel = "Information" #Use Debug for Development
  
#install sitecore instance 
$xconnectHostName = "$Prefix.xconnect" 
$MarketingAutomationReportingParams = @{     
    Path = $Path  
    Package = $Package     
    LicenseFile = $LicenseFile
    SiteName = $SiteName
    SSLCert = $SSLCert
    XConnectCert = $XConnectCert
    SqlDbPrefix = $SqlDbPrefix  
    SqlServer = $SqlServer 
    SqlReferenceDataUser = $SqlReferenceDataUser
    SqlReferenceDataPassword = $SqlReferenceDataPassword
    SqlMarketingAutomationUser = $SqlMarketingAutomationUser
    SqlMarketingAutomationPassword = $SqlMarketingAutomationPassword
    XConnectEnvironment = $XConnectEnvironment
    XConnectLogLevel = $XConnectLogLevel   
} 
Write-Host @MarketingAutomationReportingParams
Install-SitecoreConfiguration @MarketingAutomationReportingParams 
```
>Note: In comparison to the xconnect-xp1-MarketingAutomation.ps1 the following parameters has been removed: SqlCollectionUser, SqlCollectionPassword, SqlProcessingPoolsUser, SqlProcessingPoolsPassword, SqlMessagingUser, SqlMessagingPassword, SqlAdminUser and SqlAdminPassword.
4. Execute the c:\xp\xconnect-xp1-MarketingAutomationReporting.ps1 script.
```
PS C:\> .\c:\xp\xconnect-xp1-MarketingAutomationReporting.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 6 seconds to complete execution, see the [xconnect-xp1-MarketingAutomationReporting.log](xconnect-xp1-MarketingAutomationReporting.log) file.

>Note: If you need to rerun the script, perform a iisreset on the terminal, see below.
```
PS C:\>iisreset
```
5. To install xDB Reference Data role, edit the parameters of [c:\xp\xconnect-xp1-ReferenceData.ps1](xconnect-xp1-ReferenceData.ps1) scripts to reflect local settings.
```
<#
Exposed parameters for creating the xDB Reference Data role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\xconnect-xp1-ReferenceData.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp1referencedata.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.referencedata" 

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlAdminUser = "sa"
$SqlAdminPassword = "Test12345"
$SqlReferenceDataUser = "referencedatauser"
$SqlReferenceDataPassword = "Test12345"

$XConnectEnvironment ="Development" #For production environment use Production
$XConnectLogLevel = "Information" #Use Debug for Development
```
>Note: In comparison with xconnect-xp1-MarketingAutomationReport.ps1, they have the same set of parameters.
6. Execute the c:\xp\xconnect-xp1-ReferenceData.ps1 scripts.
```
PS C:\> .\xconnect-xp1-ReferenceData.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 29 seconds to complete execution, see the [xconnect-xp1-ReferenceData.log](xconnect-xp1-ReferenceData.log) file.

### Reporting Instance Installation

1. To install Reporting role, edit the parameters in the [c:\xp\sitecore-xp1-Reporting.ps1](sitecore-xp1-Reporting.ps1) scripts to reflect local settings.
```
<#
Exposed parameters for creating the Reporting Role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\sitecore-XP1-rep.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_rep.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.reporting" #The website that will be created in IIS

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default values (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlAdminUser = "sa" 
$SqlAdminPassword = "Test12345" 
$SqlCoreUser = "coreuser"
$SqlCorePassword = "Test12345"
$SqlMasterUser = "masteruser"
$SqlMasterPassword = "Test12345"
$SqlWebUser = "webuser"
$SqlWebPassword = "Test12345"
$SqlReportingUser = "reportinguser"
$SqlReportingPassword = "Test12345"

$ReportingServiceApiKey = "abcde111112222233333444445555566"
```
2. Execute the c:\xp\sitecore-xp1-Reporting.ps1 script.
```
PS C:\>.\sitecore-xp1-Reporting.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 13 seconds to complete execution, see the [sitecore-XP1-rep.log](sitecore-XP1-rep.log) file.

### Processing Instance Installation

1. To install Processing role, edit the parameters in the [c:\xp\sitecore-xp1-Processing.ps1](sitecore-xp1-Processing.ps1) script.
```
<#
Exposed parameters for creating the Processing Role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\sitecore-XP1-prc.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_prc.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.processing" #The website that will be created in IIS

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client" 

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default values (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlAdminUser = "sa" 
$SqlAdminPassword="Test12345" 
$SqlCoreUser = "coreuser"
$SqlCorePassword = "Test12345"
$SqlMasterUser = "masteruser"
$SqlMasterPassword = "Test12345"
$SqlWebUser = "webuser"
$SqlWebPassword = "Test12345"
$SqlReportingUser = "reportinguser"
$SqlReportingPassword = "Test12345"
$SqlReferenceDataUser = "referencedatauser"
$SqlReferenceDataPassword = "Test12345"
$SqlProcessingPoolsUser = "poolsuser"
$SqlProcessingPoolsPassword = "Test12345"
$SqlProcessingTasksUser = "tasksuser"
$SqlProcessingTasksPassword = "Test12345"

$SolrCorePrefix = $Prefix
$SolrUrl = "https://localhost:8983/solr" 

$XConnectCollectionService = "https://$Prefix.xconnectcollection"
$ReportingServiceApiKey = "abcde111112222233333444445555566"
```
2. Execute the c:\xp\sitecore-xp1-Processing.ps1 script.
```
PS C:\>.\sitecore-xp1-Processing.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 38 seconds to complete execution, see the [sitecore-XP1-prc.log](sitecore-XP1-prc.log) file.

### Content Management Instance Installation

1. To install Content Management role, edit the parameters in the [c:\xp\sitecore-xp1-ContentManagement.ps1](sitecore-xp1-ContentManagement.ps1) scripts to reflect local settings.
```
<#
Exposed parameters for creating the Content Management Role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\sitecore-XP1-cm.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_cm.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.contentmanagement" 
$SitecoreAdminPassword = "b"

$SSLCert = "" #Todo: needs to be provided (applicable for production environment), if not then generated by the script (applicable for development environment).
$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default values (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlAdminUser = "sa" 
$SqlAdminPassword="Test12345" 
$SqlCoreUser = "coreuser"
$SqlCorePassword = "Test12345"
$SqlMasterUser = "masteruser"
$SqlMasterPassword = "Test12345"
$SqlWebUser = "webuser"
$SqlWebPassword = "Test12345"
$SqlReportingUser = "reportinguser"
$SqlReportingPassword = "Test12345"
$SqlReferenceDataUser = "referencedatauser"
$SqlReferenceDataPassword = "Test12345"
$SqlFormsUser = "formsuser"
$SqlFormsPassword = "Test12345"
$SqlExmMasterUser = "exmmasteruser"
$SqlExmMasterPassword = "Test12345"
$SqlMessagingUser = "messaginguser"
$SqlMessagingPassword = "Test12345" 

$ExmEdsProvider = "CustomSMTP"

$SolrCorePrefix = $Prefix
$SolrUrl = "https://localhost:8983/solr" 

$ProcessingService = "https://$Prefix.processing"
$ReportingService = "https://$Prefix.reporting"
$ReportingServiceApiKey = "abcde111112222233333444445555566"

$XConnectCollectionSearchService = "https://$Prefix.collectionsearch"
$XConnectReferenceDataService = "https://$Prefix.referencedata"

$MarketingAutomationOperationsService = "https://$Prefix.marketingautomation"
$MarketingAutomationReportingService = "https://$Prefix.marketingautomationreporting"

$EXMCryptographicKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
$EXMAuthenticationKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
$TelerikEncryptionKey = "PutYourCustomEncryptionKeyHereFrom32To256CharactersLong"
```
2. Execute the c:\xp\sitecore-xp1-ContentManagement.ps1 script.
```
PS C:\>.\sitecore-xp1-ContentManagement.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 3 minute 46 seconds to complete execution, see the [sitecore-XP1-cm.log](sitecore-XP1-cm.log) file.

### Content Delivery Instance Installation

1. To install Content Delivery role, edit the parameters in [c:\xp\sitecore-xp1-ContentDelivery.ps1](sitecore-xp1-ContentDelivery.ps1) script.
```
<#
Exposed parameters for creating the Content Delivery Role, so you can change it for production
#>
$Prefix = "xp901" #This is usually the name of the site
$PSScriptRoot = "c:\xp" #This is the default destination folder from the git clone, if different then update this to point to the new location.
$Path = "$PSScriptRoot\config\sitecore-XP1-cd.json"

$Package = "$PSScriptRoot\Sitecore 9.0.1 rev. 171219 (OnPrem)_cd.scwdp.zip"
$LicenseFile = "$PSScriptRoot\license.xml" #The Sitecore License.xml file
$SiteName = "$Prefix.contentdelivery" 

$XConnectCert = "$Prefix.xconnect_client"

<#
The $Prefix, $SqlAdminUser, $SqlAdminPassword and $SqlServer needs to be changes. The rest can use the default values (for development environment purposes) but for production it's recommended to be changed.
#>
$SqlDbPrefix = $Prefix
$SqlServer = "RAMONASENIE0E1F"
$SqlCoreUser = "coreuser"
$SqlCorePassword = "Test12345"
$SqlWebUser = "webuser"
$SqlWebPassword = "Test12345"
$SqlFormsUser = "formsuser"
$SqlFormsPassword = "Test12345"
$SqlExmMasterUser = "exmmasteruser"
$SqlExmMasterPassword = "Test12345"
$SqlMessagingUser = "messaginguser"
$SqlMessagingPassword = "Test12345" 

$SolrCorePrefix = $Prefix
$SolrUrl = "https://localhost:8983/solr" 

$XConnectCollectionService = "https://$Prefix.collection"
$XConnectReferenceDataService = "https://$Prefix.referencedata"

$MarketingAutomationOperationsService = "https://$Prefix.marketingautomation"
$MarketingAutomationReportingService = "https://$Prefix.marketingautomationreporting"

$EXMCryptographicKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
$EXMAuthenticationKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
```
2. Execute c:\xp\sitecore-xp1-ContentDelivery.ps1 script
```
PS C:\>.\sitecore-xp1-ContentDelivery.ps1 <<Press Enter>>
```
>Note: The script will take about (+/-) 6 seconds to complete execution, see the [sitecore-XP1-cd.log](sitecore-XP1-cd.log) file.

## Built With

* [Sitecore 9.0 Update 1](http://www.sitecore.come) - The Sitecore XP1 Scaled Platform

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Ramon Aseniero** - *Initial work* - [Sitecore](https://github.com/raseniero)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
