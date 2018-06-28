# Sitecore XP1 Scaled Installation

This is a how-to for installing Sitecore XP in a scaled topology.

This documentation is a **work-in-progress**.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for deploying Sitecore XP1 scaled. 

### Prerequisites

What things you need to run the scripts the target environment.

* Windows Server 2016
* SQL Server 2016 SP1
* MS SQL Management Studio 2017

### Installing

A step by step series of examples that tell you how to get a development env running

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
