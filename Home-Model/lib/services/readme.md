**Services Folder**
Designed for your different app _services_.

# Example:

`fetchTrips(){ await http.get('https://jsonplaceholder.typicode.com/trips').then((response){ if (response.statusCode == 200) { // If the server did return a 200 OK response, then parse the JSON. return json.decode(response.body); } else { // If the server did not return a 200 OK response, then throw an exception. throw Exception('Failed to load trips'); } }) }`
