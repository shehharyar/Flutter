import 'package:_fav_places/widget/places_list.dart';
import 'package:flutter/material.dart';

class PalcesScreen extends StatelessWidget {
  const PalcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions:  [
          IconButton(
            onPressed: () {  },
            icon: const Icon(Icons.add, 
            ),
          )
        ],
      ),
      body: PlacesList(places: [])
    );
  }
}