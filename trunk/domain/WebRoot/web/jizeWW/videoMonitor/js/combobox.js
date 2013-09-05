// JScript File

function ComBoBox(applyTo,width,onChangeCallback)
{
    this.oSpan = null;
    this.oTextBox = null;
    this.oSelectBox = null;
    this.ver = "f";
    this.onChangeListSelection = onChangeListSelection;
    this.comBobox_initOptions = comBobox_initOptions;
    
    this.getOptionCount = getOptionCount;
    this.getSelectedIndex = getSelectedIndex;
    this.setSelectedIndex = setSelectedIndex;
    this.getOptionValue = getOptionValue;
    this.setOptionValue = setOptionValue;

    this.onChangeCallback = onChangeCallback;
    
    this.init = comBobox_init;
    this.init(applyTo,width);
}

function comBobox_init(applyTo,width)
{
	var iBrowserVersion = checkBrowser();
	if ( iBrowserVersion == 0 ) {
		alert("This page may not be displayed properly:\n\
		This product requires Microsoft Internet Explorer 5 or later browser only.");
	}
	
    var objLoginBox = document.getElementById(applyTo);
    if(!objLoginBox)
    {        
        var objLoginBox = document.createElement("SPAN");
        objLoginBox.setAttribute("id",applyTo);
        //objLoginBox.className = "combobox";
        document.getElementsByTagName("body").item(0).appendChild(objLoginBox);
    }
    if(!objLoginBox) return false;
    this.oSpan = objLoginBox;
    
    this.oSpan.innerHTML = "<INPUT /><SELECT></SELECT>";
    this.oSpan.style.width = width+"px";
 
 	this.oTextBox = objLoginBox.children( 0 );
 	this.oTextBox.id = applyTo + "_text";
 	this.oTextBox.name = applyTo + "_text";
 	this.oTextBox.style.position	=	"absolute";
 	
 	this.oSelectBox = objLoginBox.children( 1 );
 	this.oSelectBox.id	= applyTo + "_select";
 	this.oSelectBox.name = applyTo + "_select";
 	this.oSelectBox.tabIndex = -1;
 	this.oSelectBox.style.position	=	"absolute";
 
 	this.oSelectBox.calculate_absolute_X=calculate_absolute_X;
 	this.oSelectBox.calculate_absolute_Y=calculate_absolute_Y;
 	this.oSelectBox.style.setExpression("pixelLeft", "calculate_absolute_X(" + this.oTextBox.id + ")");
 	this.oSelectBox.style.setExpression("pixelTop", "calculate_absolute_Y(" + this.oTextBox.id + ")");
 		
	if ( iBrowserVersion == 6 ) {
		this.oSelectBox.style.setExpression("clip","'rect(auto auto auto '+(offsetWidth - 18)+')'");
	}
	else {
		this.oSelectBox.style.setExpression("clip","'rect(auto auto auto '+(offsetWidth - 20)+')'");
	}

	
		//oTextBox.style.pixelWidth = "100px";
		this.oSelectBox.style.pixelWidth = width;
	

	this.oTextBox.style.setExpression("pixelWidth", this.oSelectBox.id + ".offsetWidth - 18" );
	objLoginBox.style.setExpression("pixelWidth", this.oSelectBox.id + ".offsetWidth" );
    var self = this;
	this.oSelectBox.attachEvent("onchange", function(){onChangeListSelection(self);if(typeof self.onChangeCallback == "function")self.onChangeCallback();});
	
  /*
 	oTextBox.attachEvent("onchange",onChangeEditText);
	oTextBox.attachEvent("onkeyup",onEditKeyUp);
 	oTextBox.attachEvent("onkeydown",onEditKeyDown);
 	oTextBox.attachEvent("onkeypress",onEditKeyPress);
 	oTextBox.attachEvent("onblur",onEditBlur);
 
	oSelectBox.attachEvent("onchange", onChangeListSelection);
	
  */
}

/*
 *	iDefaultMode: 0 - text, 1 - index, 2 - value; default = text
 */
function comBobox_initOptions( asInitialOptions, asInitialValues, sDefaultText, iDefaultMode )
{
	if ( asInitialOptions == null ) {
		return;
	}

	// sort options array appropriately
//	if ( sort_order != "" ) {
//		asInitialOptions.sort();		
//		if ( sort_order != "a" ) {						
//			asInitialOptions.reverse();
//		}
//	}

	var iLen = asInitialOptions.length;
	var iInd;
		
	if ( iDefaultMode == null ) {
		iDefaultMode = 0;
	}
	if ( ( iDefaultMode == 1 ) && !isInteger( sDefaultText ) ) {
		iDefaultMode = 0;
	}

	var bSelectOption = ( sDefaultText != null );

	for ( iInd = 0; iInd < iLen; iInd++ ) {
		var oOption		= document.createElement("OPTION");
		var sOptionText = asInitialOptions[ iInd ];
		var sOptionValue = ( asInitialValues != null ) ? asInitialValues[ iInd ] : "";

		oOption.text	= sOptionText;
		oOption.value	= sOptionValue;
		this.oSelectBox.add(oOption);

		if ( bSelectOption ) {
			if ( ( iDefaultMode == 0 ) && ( sOptionText == sDefaultText ) ) {
				this.oSelectBox.selectedIndex = iInd;
				this.oTextBox.value = sOptionText;
			}
			if ( ( iDefaultMode == 2 ) && ( sOptionValue == sDefaultText ) ) {
				this.oSelectBox.selectedIndex = iInd;
				this.oTextBox.value = sOptionText;
			}
		}
	}

	if ( bSelectOption && ( iDefaultMode == 1 ) ) {
		var iIndex = parseInt( sDefaultText, 10 );

		if ( ( iIndex <= iLen ) || ( iIndex < 0 ) ) {
			this.oSelectBox.selectedIndex = -1;
			this.oTextBox.value = "";
		}
		else {
			this.oSelectBox.selectedIndex = iIndex;
			this.oTextBox.value = this.oSelectBox.options[ iIndex ].text;
		}
	}

	if ( !bSelectOption ) {
		this.oSelectBox.selectedIndex = -1;
		this.oTextBox.value = "";
	}
	this.oTextBox.focus();
	this.oTextBox.select();

	if ( bSelectOption ) {
		//fireTextChange();
		//fireSelectionChange( this.oSelectBox.selectedIndex );
	}
}

 
/********************************************************************
 **************************EXPOSED EVENTS****************************
 ********************************************************************/

function onChangeListSelection(oSpan)
{
	var iSelected = oSpan.oSelectBox.selectedIndex;
	var oSelected = oSpan.oSelectBox.options[iSelected];

	oSpan.oTextBox.value  = oSelected.text;
	oSpan.oTextBox.focus();
	oSpan.oTextBox.select();

	//fireSelectionChange( iSelected );
}

function fireSelectionChange( iNewSelection )
{
    oEvent = createEventObject();
    oEvent.altKey = event.altKey;
	oEvent.altLeft = event.altLeft;
    oEvent.ctrlKey = event.ctrlKey;
	oEvent.ctrlLeft = event.ctrlLeft;
    oEvent.shiftKey = event.shiftKey;
	oEvent.shiftLeft = event.shiftLeft;
    oEvent.clientX = event.clientX;
	oEvent.clientY = event.clientY;
    oEvent.offsetX = event.offsetX;
	oEvent.offsetX = event.offsetY;
    oEvent.x = event.x;
	oEvent.y = event.y;
	oEvent.selectedIndex = iNewSelection;
	event_selectionchanged.fire( oEvent );
}

function fireTextChange()
{
	oEvent = createEventObject();	
    oEvent.altKey = event.altKey;
	oEvent.altLeft = event.altLeft;
    oEvent.ctrlKey = event.ctrlKey;
	oEvent.ctrlLeft = event.ctrlLeft;
    oEvent.shiftKey = event.shiftKey;
	oEvent.shiftLeft = event.shiftLeft;
    oEvent.clientX = event.clientX;
	oEvent.clientY = event.clientY;
    oEvent.offsetX = event.offsetX;
	oEvent.offsetX = event.offsetY;
    oEvent.x = event.x;
	oEvent.y = event.y;
	event_textchanged.fire( oEvent );
}


/********************************************************************
 **************************METHODS***********************************
 ********************************************************************/
function getOptionCount()
{
	return this.oSelectBox.options.length;
}
 
function getSelectedIndex()
{
	return this.oSelectBox.selectedIndex;
}

function setSelectedIndex( iSelectedIndex )
{
	if ( !isInteger( iSelectedIndex ) ) {
		return -1;
	}
	var iLen = this.oSelectBox.options.length;
	if ( ( iSelectedIndex < 0 ) || ( iSelectedIndex >= iLen ) ) {
		return -1;
	}
	this.oSelectBox.selectedIndex = iSelectedIndex;

	this.oTextBox.value = this.oSelectBox.options[ iSelectedIndex ].text;
	this.oTextBox.focus();
	this.oTextBox.select();

	//fireTextChange();
	//fireSelectionChange( iSelectedIndex );

	return iSelectedIndex;
}

function getOptionValue( iIndex ) 
{
	if ( !isInteger( iIndex ) ) {
		return "Error";
	}

	var iLen = this.oSelectBox.options.length;
	if ( ( iIndex < 0 ) || ( iIndex >= iLen ) ) {
		return "Error";
	}
	return this.oSelectBox.options[ iIndex ].value;
}

function setOptionValue( iIndex, sValue )
{
	if ( !isInteger( iIndex ) ) {
		return -1;
	}

	var iLen = this.oSelectBox.options.length;
	if ( ( iIndex < 0 ) || ( iIndex >= iLen ) ) {
		return -1;
	}
	this.oSelectBox.options[ iIndex ].value = sValue;
	return iIndex;
}

/********************************************************************
 **************************INTERNAL FUNCTIONS************************
 ********************************************************************/
function calculate_absolute_X( theElement )
{
	var xPosition = 0;

	//while ( theElement != null )
	while ( ( theElement != null ) && ( theElement.id != this.id ) )
	{
		xPosition += theElement.offsetLeft;
		theElement = theElement.offsetParent;
	}

	return xPosition;
}

function calculate_absolute_Y( theElement )
{
	var yPosition = 0;

//	while ( theElement != null )
	while ( ( theElement != null ) && ( theElement.id != this.id ) )
	{
		yPosition += theElement.offsetTop;
		theElement = theElement.offsetParent;
	}

	return yPosition;
}

function isInteger( iNumber )
{
	if ( isNaN( iNumber ) ) {
		return false;
	}
	return ( iNumber == parseInt( iNumber, 10 ) );
}

function checkBrowser()
{
	var av=navigator.appVersion;

	// Check if IE and if so, check version
	var iMSIE=parseInt(av.indexOf("MSIE"));

	if (iMSIE>=1)
	{
		// Get major version and write appropriate style
		var iVer=parseInt(av.charAt(iMSIE+5));
		if ( iVer >= 6 ) {
			return 6;
		}
		if (iVer>=5)
		{
			return 5;
		}
	} 
	return 0;
}
 