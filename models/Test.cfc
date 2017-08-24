component extends="api"{
	
	public function test(Connection) {
		var api='test.json';	
		
		return CallApi(api,connection);
	}

}	