
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp/widgets/image_input.dart';
class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key, this.id});
  final String? id;
  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
 File? _selectedImage;
  @override
  Widget build(BuildContext context) {
     final text= widget.id != null ? "Edit Product" :  "Add Product";
    print(text);     
     return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        foregroundColor:Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text(widget.id != null ? "Edit Product" :  "Add Product"),
      ),
      backgroundColor:  Theme.of(context).colorScheme.primary.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child:Column(
              
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    TextFormField(
                      decoration: InputDecoration(hintText: "Name",
                       prefixIcon: const Icon(Icons.phone_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    ),
                   const SizedBox(height: 20,),
                    ImageInput(onPickImage: (image) {
                _selectedImage = image;
              }, )
                  ],
                )  ,),
        ),
      ),
      

    );
  }
}