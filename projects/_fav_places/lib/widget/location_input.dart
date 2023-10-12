// ignore_for_file: unused_local_variable
import 'dart:convert';

import 'package:_fav_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectLocation});
  final void Function(PlaceLocation location) onSelectLocation;
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  var _isGettingLocation = false;
  
  String get locationImage {
    if (pickedLocation == null) {
      return '';
    }
    final lat = pickedLocation!.latitude;
    final lng = pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag';
  }

  void _getCurrentLocation() async{

  
  Location location = Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (serviceEnabled) {
    return;
  }
}


permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}

setState(() {
  _isGettingLocation = true;
});

locationData = await location.getLocation();
final lat = locationData.latitude;
final lng = locationData.longitude;
if(lat == null || lng == null){
  AlertDialog(
    title: const Text('Could not get the location.'),
    content: Text("Longitude and latitude are not fetched."),
    actions: [
        Text("Ok!")
    ],
    elevation: 2.0,
    backgroundColor: Theme.of(context).colorScheme.onError,
  );
  return;
}
final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDLcwxUggpPZo8lcbH0TB4Crq5SJjtj4ag');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

setState(() {
  pickedLocation= PlaceLocation(latitude: lat, longitude: lng, address: '$lat + $lng');
  _isGettingLocation= false;
});

widget.onSelectLocation(pickedLocation! as PlaceLocation);
// print(locationData.latitude);
// print(locationData.longitude);

  }
  @override
  Widget build(BuildContext context) {
      Widget previewContent = Text(
            "No Location chosen",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          );
              if (pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if(_isGettingLocation){
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent 
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Get current location")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text("Select on Map")),
          ],
        )
      ],
    );
  }
}
