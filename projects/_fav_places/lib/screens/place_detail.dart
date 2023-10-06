import 'package:_fav_places/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget{
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(place.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          ),
        ],
      )
    );
  }
}