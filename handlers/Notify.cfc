/**
* I handle all imcoming notifications
*
* The API supports follwing events: IncomingCall, CallAccepted, HungUp
*
* Attention: Placetel Events are submitted as form parameter
* Since event is reserved for Coldbox events, the Placetel event can not be found in RC
*
* 
*/
component{

	
	function index(event,rc,prc){
		
		// We need to set placetel event explictly from form or url
		var placetelEvent ='';
		
		if(structKeyExists(url,'event'))
			placetelEvent = url.event;
			
		if(structKeyExists(form,'event'))
			placetelEvent = form.event;
			
		
		// in Coldbox event can not be used
		// so we have to check if it is in the url scope
		if(placetelEvent eq '')
			return 'Event is missing';
			

		switch(placetelEvent){
			case 'IncomingCall':
			case 'CallAccepted':
			case 'HungUp':
				announceInterception( 'placetel_'&placetelEvent,rc );
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