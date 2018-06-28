# Sitecore 9.0 Scaled Installation Notes

This is a guide or a reference for installing Sitecore 9.0 in a fully scaled on-premise environment.

This documentation is still a **work-in-progress**, do expect constant updates.

## Getting Started

These instructions will serve as a guide or a reference for deploying Sitecore 9.0 in a fully scaled on-premise environment. 

In the following scenario below, every core role and XP service role is performed by a dedicated server. This is a pre-built topology and is also known as XP1 Scaled. However, roles can be combine into a single instance, e.g. all Solr roles (i.e. xDB and CMS Solr Cores) can be installed in a single Solr instance. 

We will be referencing *the diagram* below in our instructions to come, please familiarize it!

![fully-scaled-simple1](https://user-images.githubusercontent.com/2329372/42052718-721db50a-7ac4-11e8-8709-abb304179e2c.png)

## Prerequisites

Depending on the role or instance, each has it's own respective software prerequisites, but the *general prerequisites* are the following below.

* Windows Server 2016
* SQL Server 2016 SP1 with SQL Management Studio 2017
* IIS 10
* .NET Framework 4.6.2 or later
* PowerShell 5.1 or later
* Sitecore Installation Framework Module (SIF)
* Any Web Browsers in this list: Microsoft Internet Explorer 11, Mozilla Firefox, Google Chrome or Microsoft Edge 

For the Hardware requirements, please refer to the Sitecore 9.0 Installation Guide. 

For each role or instance in *the diagram*, find their respective prerequesites below.

### Solr Instance

* Solr 6.6.2
* Chocolatey 0.10.11
* Java/JRE 1.8 (installed using Chocolatey)
* NSSM 2.24 (installed using Chocolatey)
* OpenSSL.Light 1.1.0 (installed using Chocolatey)

To setup *Solr* instance see section [Installation->Solr]

### XConnect Instance
```
TODO: list prerequisites
```

### xDB Services Instance
```
TODO: list prerequisites
```

### Processing Instance
```
TODO: list prerequisites
```

### Reporting Instance
```
TODO: list prerequisites
```

### Content Management Instance
```
TODO: list prerequisites
```

### Content Delivery Instance
```
TODO: list prerequisites
```

## Installation 

The general approach is to start with setting up *Solr* instance then followed by *XConnect*, *xDB Services*, *Content Management*, *Content Delivery*, *Processing* and *Reporting* instances.

### Installation Folder

1. Clone this repository into an *installation folder*.

> I.e.: c:\xp or d:\xp in this example.

2. Download and extract the *Sitecore 9.0.1 rev. 171219 (WDP XP1 packages).zip* to the *installation folder*. 

> Note: All *.zip files should be under directly of the root of the *installation folder*.

### Solr Instance

1. Install Chocolatey
2. Install NSSM using Chocolatey
2. Install JRE 1.8 using Chocolatey
3. Install OpenSSL using Chocolatey
4. Install Solr 6.2.2
5. Install SSL
6. Setup as a Service using NSSM

### General Installation
1. Install Windows Server 2016
2. Add IIS Role 10
	a. IIS Console
3. Add .Net Framework 4.6.2 feature
4. Install MS SQL Server 2016 SP1
5. Install MS SQL Management Studio 2017
6. If use for Developer's environment Then
	a. Install Visual Studio 2017 Professional
7. Install Prerequisite softwares for XP
	a. If Microsoft Visual C++ 2015 Redistributable does not exist Then
		i. Install vc_redist.x64.exe 
8. Set NETWORK SERVICE with Modify permissino to c:\inetpub\wwwroot
9. Set IIS_IUSRS with Modify permission to %WINDIR%\temp\
10. Set IIS_IUSRS with Modify permission to %WINDIR%\Globalization\
11. Set IIS_IUSRS with Modify permission to %PROGRAMDATA%\Microsoft\Crypto 
12. If Powershell version (i.e. $PSVersion.PSVersion) is < 5.1 Then
	a. Install Powershell version 5.1
13. Install WebPlatformInstaller_amd64_en-US.msi (Web Platform Installer 5.0)
14. Install IIS Manager from the Add Features in the Server Management
15. Install WebPlatformIsntaller_amd64_en-US (Web Platform Installer)
16. Install Web Deploy 3.6 for Hosting Servers using Web Platform Installer
17. Install UrlRewrite2.exe (URLRewrite2) using Web Platform Installer
18. Install DacFramework-x64.msi (Microsoft SQL Server Data-Tier Application Framework (DacFx) version 2016) 
19.  Install SQLSysClrTypes.msi 
20. Clear the Web Platform Installer download cache
21. Enable Contained Database Authentication  
	a. Run query = sp_configure 'contained database authentication', 1; GO RECONFIGURE; GO
22. Install Solr 6.2.2
	a. Install NSSM use Chocolatey
	b. Install JRE 1.8 use Chocolatey
	c. Install OpenSSL use Chocolatey
	d. Install Solr 6.2.2
	e. Install SSL
	f. Setup as Service
23. Set Up the Sitecore Installation Framework Module using Powershell
	a. Execute the following commands below
		i. Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/scpowershell/api/v2 
		ii. Install-Module SitecoreInstallFramework 
		iii. Update-Module SitecoreInstallFramework 
		iv. Validate installation by running the command below
			1) Get-Module SitecoreInstallFramework –ListAvailable 
24. Create a c:\xp installation folder then download the following
	a. Depending on the type of installation download the necessary version
		i. Sitecore 9.0.1 rev. 171219 (WDP XP0 packages).zip - Single
		ii. Sitecore 9.0.1 rev. 171219 (WDP XP1 packages).zip - Scaled
	b. Download xp-Installation-script.ps1
25. Edit and Run the Installation Script 


End with an example of getting some data out of the system or using it for a little demo

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
