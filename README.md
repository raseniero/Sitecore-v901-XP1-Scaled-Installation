Installation Steps:

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
