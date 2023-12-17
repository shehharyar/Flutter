import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _showBottomModal(BuildContext ctx){
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
      context: ctx , builder: (_){
      return  SafeArea(    
          child:  Wrap( 
              spacing: 50,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text("Upload Image", style: TextStyle(
                    fontFamily:"Roboto",
                    fontSize: 25,
                    color: Theme.of(context).colorScheme.onPrimary
                  ),),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: ListTile(
                    onTap:()=> _takePicture("Camera"),
                    title: const Text("Camera", style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),),
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 199, 198, 198),
                        child:  Icon(Icons.camera_alt_outlined,
                        size: 24,
                        ),
                      ) ,
                
                   ),
                ),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: ListTile(
                    onTap:()=> _takePicture("Gallery"),
                    title: const Text("Gallery", style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700
                      ),),
                      leading: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 199, 198, 198),
                        child:  Icon(Icons.browse_gallery_outlined,
                        size: 24,
                        ),
                      ) ,
                
                   ),
                ),
                // GestureDetector(
                //   onTap:() =>_takePicture("Camera") ,
                //   child: const Row(children: [
                //     Text("Camera", style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.w700
                //     ),),
                //     Icon(Icons.camera_alt_outlined,
                //     size: 24,
                //     )
                //   ],),
                // ),
                // InkWell(
                //   onTap:() => _takePicture("Gallery"),
                //   child: const Row(children: [
                //     Text("Gallery", style: TextStyle(
                //       fontSize: 24,
                //       fontWeight: FontWeight.w700
                //     ),),
                //     Icon(Icons.browse_gallery_outlined,
                //     size: 24,
                //     )
                //     ],),
                // ),
              ],
            ),
      );   
      
    }
    );
  }

  void _takePicture(String imageSrc) async {
    
    
    final imagePicker = ImagePicker();
    
    bool _IsCamera = imageSrc == 'Camera';

    final pickedImage =await imagePicker.pickImage(source: _IsCamera? ImageSource.camera : ImageSource.gallery, maxWidth: 600);

    if (pickedImage == null) {
      print("Not Allowed.");
      return;
    }

    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon:  Icon(Icons.camera,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      label:  Text('Take Picture',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer ),
      ),
      onPressed: () => _showBottomModal(context),
    );

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: ()=> _showBottomModal(context),
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}