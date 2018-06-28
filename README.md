# Sitecore 9.0 Scaled Installation Notes

This is a guide or a reference for installing Sitecore 9.0 in a fully scaled on-premise environment.

This documentation is still a **work-in-progress**, do expect constant updates.

## Getting Started

These instructions will serve as a guide or a reference for deploying Sitecore 9.0 in a fully scaled on-premise environment. 

In the following scenario below, every core role and XP service role is performed by a dedicated server. This is a pre-built topology and is also known as XP1 Scaled. However, roles can be combine into a single instance, e.g. all Solr roles (i.e. xDB and CMS Solr Cores) can be installed in a single Solr instance. 

We will be referencing *the diagram* below in our instructions to come.

![fully-scaled-simple1](https://user-images.githubusercontent.com/2329372/42052718-721db50a-7ac4-11e8-8709-abb304179e2c.png)

## Prerequisites

Depending on the role or instance, each has it's own respective software prerequisites, but the *general prerequisites* are the following below.

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

To setup *Solr* instance see section [Installation->Solr Instance](README.md#solr-instance-1)

### All Instances

This includes *XConnect*, *xDB Services*, *Content Management*, *Content Delivery*, *Processing* and *Reporting* instances.

* Refer to the *general prerequisites* for applicable prerequisites
* Add IIS role with IIS Management Console feature
* Add .Net Framework 4.6 feature
* Microsoft Visual C++ 2015 Redistributable (vc_redist.x64.exe)
* Web Platform Installer 5.0 (WebPlatformInstaller_amd64_en-US.msi)
* Web Deploy 3.6 for Hosting Servers using Web Platform Installer
* UrlRewrite2.exe (URLRewrite2) using Web Platform Installer
* Microsoft SQL Server Data-Tier Application Framework (DacFx) version 2016 (DacFramework-x64.msi)
* SQLSysClrTypes.msi 
* SQLCMD

## Installation 

The general approach is to start with setting up *Solr* instance then followed by *XConnect*, *xDB Services*, *Content Management*, *Content Delivery*, *Processing* and *Reporting* instances.

### General Installation

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
9. Enable Contained Database Authentication by running a sql query below
```
sp_configure 'contained database authentication', 1; GO RECONFIGURE; GO
```

### Solr Instance

1. Install Chocolatey
2. Install NSSM using Chocolatey
3. Install JRE 1.8 using Chocolatey
4. Install OpenSSL using Chocolatey
5. Install Solr 6.2.2
6. Install SSL
7. Setup as a Service using NSSM
8. Edit and run c:\xp\sitecore-SolrCores.ps1 to configure the cores for a Sitecore deployment. if the cores exist, they will be overwritten.
9. Edit and run c:\xp\xconnect-SolrCores.ps1 to configure the cores for an XConnect deployment. if the cores exist, they will be overwritten.

## Built With

* [Sitecore 9.0 Update 1](http://www.sitecore.come) - The XP Platform
* [Chocolatey](http://www.chocolatey.org) - The Windows Packager

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
