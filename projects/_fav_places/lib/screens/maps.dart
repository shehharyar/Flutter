import 'package:_fav_places/model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
    MapsScreen({
    super.key,
    required this.location,
    //  this.location =  const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ''),
    this.isSelecting = true,
  });

 var location =  PlaceLocation(latitude: 37.422, longitude: -122.084, address: '' );
  final bool isSelecting;
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? "Pick Your Location" :  'Your Location'),
        actions: [
          if(widget.isSelecting)
          IconButton(
            onPressed: (){
              Navigator.of(context).pop(_pickedLocation);
            }, 
            icon: const  Icon(Icons.save))
        ],
      ),
      body: GoogleMap(
        onTap: (position) {
          setState(() {
            _pickedLocation= position;   
          });
        },
        initialCameraPosition: CameraPosition(
        target: LatLng(widget.location.latitude, widget.location.longitude),
        zoom: 16       
        ),
        markers: (_pickedLocation == null && widget.isSelecting) ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation?? LatLng(widget.location.latitude, widget.location.longitude)
          )
        },
        ),


    );
  }
}