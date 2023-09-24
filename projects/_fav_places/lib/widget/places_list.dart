import 'package:_fav_places/model/place.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget{
  const PlacesList({super.key, required this.places});

  final List<Place> places;
  @override
  Widget build(BuildContext context) {
   if(places.isEmpty){
    return const Center(child: Text("No places added yet."),);
   }
   return Scaffold(
    appBar: AppBar(
      title: const Text("Your PLaces") 
      ),
      body: ListView.builder(
        itemCount: places.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(
            places[index].title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),
          ),
        )),
      );
  }
}