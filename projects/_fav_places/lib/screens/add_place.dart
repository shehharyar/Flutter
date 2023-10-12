import 'dart:io';

import 'package:_fav_places/model/place.dart';
import 'package:_fav_places/provider/user_places.dart';
import 'package:_fav_places/widget/image_input.dart';
import 'package:_fav_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget{
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState(){
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen>{
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

void _savePlace(){
  final enteredTitle =_titleController.text;
  if(enteredTitle.isEmpty || _selectedImage == null){
    return;
  }

  ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
Navigator.of(context).pop();
}

@override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place") ,
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration( labelText: "Title"),
              controller: _titleController,
            ),
            const SizedBox(height: 12,),
            ImageInput(onPickImage: (image) {
              _selectedImage = image;
            },),
            const SizedBox(height: 12,),
           LocationInput(
            onSelectLocation:(location) {
              _selectedLocation= location;
            },
           ),
            const SizedBox(height: 12,),
            ElevatedButton.icon(
              onPressed: _savePlace, 
            icon: const Icon(
            Icons.add
            ), 
            label: const Text("Add"))
          ],
        ) ),
    );
  }
}