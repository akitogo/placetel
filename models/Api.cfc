component {


	public function get(Connection) {
		
		return CallApi(variables.api,connection);
	}	

	
	public string function getEndpoint(apiUri,connection) {
		return connection.geturi()&connection.getapi()&arguments.apiUri;
	}

	public any function CallApi(string api, PlacetelConnection Connection,struct parameters) {
		var stuResponse = {};
		var httpService = new http(); 
		    httpService.setMethod("post"); 
		    httpService.setUrl(getEndpoint(api,Connection));
		    

		    httpService.addParam(type="formfield", name="api_key", value="#Connection.getapikey()#");

			if(!isNull(arguments.parameters)){
			    for(var i in arguments.parameters){
				    httpService.addParam(type="formfield", name="#lcase(i)#", value="#arguments.parameters['#i#']#");
			    }
		    }
		var result = httpService.send().getPrefix();
		if (result.status_code eq "200")
			return DeserializeJSON(result.filecontent);
			
	}		
}	
	