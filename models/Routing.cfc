component extends="api"{
	variables.api='getRouting.json';	

	public function get(Connection,required string number) {
		
		return CallApi(variables.api,connection);
	}	
}	
