# Placetel
Implements Placetel API and notify for Coldfusion / Coldbox
Placetel is a German Voip Provider, with this api you can be notfied of calls and other events, you can do routing of phone calls

For more information see:

https://www.placetel.de/hilfe/telefonanlage/api

https://github.com/Placetel/call-control-notify-api

## Installation 
You will need a Placetel Account to work with this API



```
box install placetel
```



## Usage
### Notify
Use the notify handler to interact with incoming calls. 
 - Enter the endpoint in you Placetel Api account, maybe you need to contact customer service to have access to this entry
 - Enter your url like: https://yourdomain/index.cfm/placetel/notify
 - Implement you own intercepter, for example see interceptors/notify.cfc
 
```
	function placetel_CallAccepted( event, interceptData ) {
		var prc = event.getCollection(private=true);
		var rc	= event.getCollection();

//		prc.placetelResponse=Notify.reject();

//		prc.placetelResponse=Notify.reject("busy");

//		prc.placetelResponse=Notify.hangup();

//		prc.placetelResponse=Notify.queue(1234);
	}

```
### Interact with the api
 - call somebody
```
		var myVoipAccount='xxxxx@blf.finotel.com';
		var somebody='069999999'; 

		var ptc = getModel("PlacetelConnection@placetel");
		ptc.setApiKey('YOUR API KEY GOES HERE');

		
		// this initiate a call, ring your phone/voip client 
		// and dial to somebody
		var calling = getModel("InitiateCall@placetel");
		calling.call(ptc,myVoipAccount,somebody);		
```
## Written by
www.akitogo.com

## Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
