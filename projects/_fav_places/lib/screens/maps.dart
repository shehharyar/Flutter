import 'package:_fav_places/model/place.dart';
import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key, 
  this.location= const PlaceLocation(
    latitude: 37.422, 
    longitude: -122.084, 
    address: ''
    ),
  });
  final PlaceLocation location;
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}