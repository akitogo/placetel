component {

  /**
   * Forward to one or multiple targets. 
   *
   * @param string target  
   *  use target for a single number
   * @param array targets  
   *  or use targets for multiple numbers
   *  array of structs
   *  	{numbers=['123','1234',12345]}
   *	,{ringtime=5,numbers=['234','2345',2346]}   
   * @param string forward_announcement  
   *  Play selected announcement and transfer to targets, e.g. 1234
   *
   * @param boolean music_on_hold  
   *  Play music on hold instead of standard ringtone? Default is false
   * @param boolean voicemail  
   *  Send call to voicemail if no routing target answered? Default is true
   * @param string voicemail_announcement  
   *  Mailbox announcement, e.g. 1234
   * @param boolean voicemail_as_attachment  
   *  Send voicemail as MP3 attachment? Default is false
   * @param string forward_announcement  
   *  Play selected announcement and transfer to targets, e.g. 1234
   *
   * @return xml
   *
   * @see https://github.com/Placetel/call-control-notify-api
   */
	public xml function forward(
		string target =''
		,array targets =[]
		,boolean music_on_hold=false
		,boolean voicemail=true
		,string voicemail_announcement=''
		,boolean voicemail_as_attachment=false
		,string forward_announcement=''
	) {
		var xml = XmlNew();
		var response = XmlElemNew( xml, "", "Response" );
		
		ArrayAppend(response.XmlChildren,XmlElemNew( xml, "", "Forward" ));
		
		// we only set if not default value
		if(arguments.music_on_hold)
			response.XmlChildren[1].XmlAttributes['music_on_hold'] = true;

		if(!arguments.voicemail)
			response.XmlChildren[1].XmlAttributes['voicemail'] = false;

		if(arguments.voicemail_announcement neq "")
			response.XmlChildren[1].XmlAttributes['voicemail_announcement'] = arguments.voicemail_announcement;

		if(arguments.voicemail_as_attachment)
			response.XmlChildren[1].XmlAttributes['voicemail_as_attachment'] = true;

		if(arguments.forward_announcement neq "")
			response.XmlChildren[1].XmlAttributes['voicemail_announcement'] = arguments.forward_announcement;
			
		// use this to set a single number
		if(arguments.target neq ""){
			ArrayAppend(response.Forward.XmlChildren,XmlElemNew( xml, "", "Target" ));
			ArrayAppend(response.Forward.Target.XmlChildren,XmlElemNew( xml, "", "Number" ));
			response.Forward.Target.Number.XMLText=arguments.target;
		}
		
		if(isArray(arguments.targets)){
			for(var singleTarget in arguments.targets){
				ArrayAppend(response.Forward.XmlChildren,XmlElemNew( xml, "", "Target" ));
				// check and set ringtime
				if(structKeyExists(singleTarget,'ringtime') and singleTarget.ringtime gt 0)
					response.Forward.XmlChildren[arrayLen(response.Forward.XmlChildren)].XmlAttributes['ringtime'] = singleTarget.ringtime;
				// add all numbers
				for(var number in singleTarget['numbers']){
					response.Forward.XmlChildren[arrayLen(response.Forward.XmlChildren)].XmlChildren[arrayLen(response.Forward.XmlChildren[arrayLen(response.Forward.XmlChildren)].XmlChildren)+1]=XmlElemNew( xml, "", "Number" );
					response.Forward.XmlChildren[arrayLen(response.Forward.XmlChildren)].XmlChildren[arrayLen(response.Forward.XmlChildren[arrayLen(response.Forward.XmlChildren)].XmlChildren)].XMLText=number;
				}
			}
		}

		return response;
	}
	

  /**
   * Reject an unwanted call or pretend to be busy.
   *
   * @param string reason  
   *   "busy" or EMPTY string
   *
   * @return xml
   *
   * @see https://github.com/Placetel/call-control-notify-api
   */
	public xml function reject(string reason="") {
		var xml = XmlNew();
		var response = XmlElemNew( xml, "", "Response" );
		
		ArrayAppend(response.XmlChildren,XmlElemNew( xml, "", "Reject" ));
		
		if(arguments.reason neq "")
			response.XmlChildren[1].XmlAttributes['reason'] = arguments.reason;

		return response;
	}

  /**
   * A simple hangup.
   *
   * @return xml
   *
   * @see https://github.com/Placetel/call-control-notify-api
   */
	public xml function hangup() {
		var xml = XmlNew();
		var response = XmlElemNew( xml, "", "Response" );
		
		ArrayAppend(response.XmlChildren,XmlElemNew( xml, "", "Hangup" ));
		
		return response;
	}

  /**
   * Send call to a Contact Center Queue.
   *
   * @return xml
   *
   * @see https://github.com/Placetel/call-control-notify-api
   */
	public xml function queue(numeric queueId ="") {
		var xml = XmlNew();
		var response = XmlElemNew( xml, "", "Response" );
		
		ArrayAppend(response.XmlChildren,XmlElemNew( xml, "", "Queue" ));
		response.XmlChildren[1].XmlAttributes['queue_Id'] = arguments.queueId;
		
		return response;
	}	


}	
	