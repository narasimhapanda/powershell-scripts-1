#Requires -Version 3.0
#This File is in Unicode format.  Do not edit in an ASCII editor.

<#
.SYNOPSIS
	Creates a complete inventory of a Citrix XenApp 6.5 farm using Microsoft Word 2010 or 2013.
.DESCRIPTION
	Creates a complete inventory of a Citrix XenApp 6.5 farm using Microsoft Word and PowerShell.
	Creates either a Word document or PDF named after the XenApp 6.5 farm.
	Document includes a Cover Page, Table of Contents and Footer.
	Version 4.xx includes support for the following language versions of Microsoft Word:
		Catalan
		Danish
		Dutch
		English
		Finnish
		French
		German
		Norwegian
		Portuguese
		Spanish
		Swedish
		
.PARAMETER CompanyName
	Company Name to use for the Cover Page.  
	Default value is contained in HKCU:\Software\Microsoft\Office\Common\UserInfo\CompanyName or
	HKCU:\Software\Microsoft\Office\Common\UserInfo\Company, whichever is populated on the 
	computer running the script.
	This parameter has an alias of CN.