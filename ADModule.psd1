@{
	# Script module or binary module file associated with this manifest
	ModuleToProcess = 'ADModule.psm1'
	
	# Version number of this module.
	ModuleVersion = '0.0.1'
	
	# ID used to uniquely identify this module
	GUID = 'd5ba333f-5210-4d69-83f0-150dd0909139'
	
	# Author of this module
	Author = 'Carlos Medina'
	
	# Company or vendor of this module
	CompanyName = ' '
	
	# Copyright statement for this module
	Copyright = 'Copyright (c) 2019 Carlos Medina'
	
	# Description of the functionality provided by this module
	Description = 'Modulo para la gestión del directorio activo'
	
	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '4.0'
	
	# Modules that must be imported into the global environment prior to importing
	# this module
	#RequiredModules = @(
	#	@{ ModuleName='PSFramework'; ModuleVersion='0.10.31.179' }
	#)
	
	# Assemblies that must be loaded prior to importing this module
	 #RequiredAssemblies = @('bin\ssh.net\lib\net40\Renci.SshNet.dll')
	
	# Functions to export from this module
	FunctionsToExport = '*'
	
	# Cmdlets to export from this module
	CmdletsToExport = ''
	
	# Variables to export from this module
	VariablesToExport = ''
	
	# Aliases to export from this module
	AliasesToExport = ''
	
	# List of all modules packaged with this module
	ModuleList = @()
	
	# List of all files packaged with this module
	FileList = @()
	
	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData = @{
		
		#Support for PowerShellGet galleries.
		PSData = @{
			
			# Tags applied to this module. These help with module discovery in online galleries.
			# Tags = @()
			
			# A URL to the license for this module.
			# LicenseUri = ''
			
			# A URL to the main website for this project.
			# ProjectUri = ''
			
			# A URL to an icon representing this module.
			# IconUri = ''
			
			# ReleaseNotes of this module
			# ReleaseNotes = ''
			
		} # End of PSData hashtable
		
	} # End of PrivateData hashtable
}