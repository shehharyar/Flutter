import 'package:_fav_places/provider/user_places.dart';
import 'package:_fav_places/screens/add_place.dart';
import 'package:_fav_places/widget/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PalcesScreen extends ConsumerWidget {
  const PalcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final userPlaces= ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions:  [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
            },
            icon: const Icon(Icons.add, 
            ),
          )
        ],
      ),
      body: PlacesList(places: userPlaces)
    );
  }
}