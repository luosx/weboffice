///////////////////////////////////////////////////////////////////////////////
//
//  installcreatesilverlight.js   			version 1.0
//
//  This file is provided by Microsoft as a helper file for websites that
//  incorporate Silverlight Objects. This file is provided under the Silverlight 
//  SDK 1.0 license available at http://go.microsoft.com/fwlink/?linkid=94240.  
//  You may not use or distribute this file or the code in this file except as 
//  expressly permitted under that license.
// 
//  Copyright (c) 2007 Microsoft Corporation. All rights reserved.
//
///////////////////////////////////////////////////////////////////////////////
if(!window.Silverlight)
    window.Silverlight={};

Silverlight.InstallAndCreateSilverlight = function(version, SilverlightDiv, installExperienceHTML, installPromptDivID, createSilverlightDelegate)
{
    var RetryTimeout=3000;	              //The interval at which Silverlight instantiation is attempted(ms)	
    if ( Silverlight.isInstalled(version) )
    {
	createSilverlightDelegate();
    }
    else {
        Ext.getDom('loginDiv').innerHTML = "";
	if ( installExperienceHTML && SilverlightDiv )
	{
	    SilverlightDiv.innerHTML = installExperienceHTML;
	    
	    document.body.innerHTML;
	}
        if (installPromptDivID)
        {
	    var installPromptDiv = document.getElementById(installPromptDivID);
	    if ( installPromptDiv )
		installPromptDiv.innerHTML = Silverlight.createObject(null, null, null, {version: "4.0", inplaceInstallPrompt:true},{}, null);
        }
	if ( ! (Silverlight.available) )
	{
	    TimeoutDelegate = function()
	    {
	        Silverlight.InstallAndCreateSilverlight("4.0", null, null, null, createSilverlightDelegate);
	    }
	    setTimeout(TimeoutDelegate, RetryTimeout);
	}
    }
}