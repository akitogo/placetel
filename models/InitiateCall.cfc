component extends="api"{
	variables.api='initiateCall.json';	
	
	/**
	* sipuid e.g. z.B. 777332423@sip.finotel.com
	* e.g. 0221123456
	*/
	public function call(connection,string sipuid,string target) {
		
		return CallApi(variables.api,connection,{sipuid=arguments.sipuid,target=arguments.target});
	}	
}	