/**
* A normal ColdBox Event Handler
*/
component{

	
	function index(event,rc,prc){
		// in Coldbox event can not be used
		// so we have to check if it is in the url scope
		if(!structKeyExists(url,'event'))
			return 'Event is missing';
			

		switch(url.event){
			case 'IncomingCall':
			case 'CallAccepted':
			case 'HungUp':
				announceInterception( 'placetel_'&url.event,rc );
				break;
			default:
				return 'Event is not supported';
		}
		
		// placetelResponse will be set within interceptoer
		// which has to be implemented in custom module 
		if(structKeyExists(prc,'placetelResponse') and isXml(prc.placetelResponse)){
			event.renderData(
			    type="text",
			    data=toString(prc.placetelResponse),
			    contentType="application/xml"
			);
		} else {
			  event.noRender();
		}
		
		
	}

}