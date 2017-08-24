component accessors="true" {
	property name="uri";
	property name="api";
	property name="apiKey";
	
	public PlacetelConnection function init() {
		variables.uri		='https://api.placetel.de/';
		variables.api		='api/';
		variables.apiKey	='';

		return this;
	}
}	