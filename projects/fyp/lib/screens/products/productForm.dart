import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/UI/TextInput.dart';
import 'package:fyp/widgets/UI/image_input.dart';
import 'package:uuid/uuid.dart';
final _firebase = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;


class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key, required this.sid});
  final String sid;
  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
 File? _selectedImage;
 final _form = GlobalKey<FormState>();
   var uuid = const Uuid();

 var title="";
 var price="";
 var cost="";
 var stock ="";
 var others ="";


void _addProduct () async{
   final isValid = _form.currentState?.validate() ?? false;

    if (!isValid) {
     ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(
          content: Text( 'Please enter a valid input.'),
        ),
      );
      return;
    }
    _form.currentState!.save();

    try{
      final user = _firebase.currentUser!;
      final productId =uuid.v4();
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('$user.jpg');

        await storageRef.putFile(_selectedImage!);

        final imageUrl = await storageRef.getDownloadURL();
      final products= await database.ref().child('products').child(productId).set({
       "title": title,
       "Cost": cost,
       "price": price,
       "stock": stock,
        "Others":others,
       "imageUrl" : imageUrl,
       "id": productId,
       'productOwnerid': user.uid,
       'shopId': widget.sid
      });
          

     final shops= await database.ref().child('shops').push().get();
      print(shops.value);
    // print(product);
    } on FirebaseException

catch(e){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? "Can't send data...")));
    }

    Navigator.of(context).pop();
}



  @override
  Widget build(BuildContext context) {
    //  final text= widget.id != null ? "Edit Product" :  "Add Product";
    // print(text);     
     return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        foregroundColor:Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        title: Text("Add Product"),
      ),
      backgroundColor:  Theme.of(context).colorScheme.primary.withOpacity(0.9),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _form,
              child:Column(
              
                  children: [
                    TextInput(onSaved: (value) {
                        setState(() {
                          title= value!;
                        });                       
                      }, 
                       validator: (value){
                        if(value!.isEmpty){
                          return "This field should not be empty..";
                        }
                      },label: "Title",
                      icon: Icons.tag_outlined,
                      ),
                   const SizedBox(height: 20,),
                    TextInput(
                        icon: Icons.bar_chart_outlined,
                          label: "Stock",
                          onSaved: (value) {
                        setState(() {
                          stock= value!;
                        });                       
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "This field should not be empty..";
                        }
                      },
                      keyboardType: TextInputType.number,
                      
                    ),
                   const SizedBox(height: 20,),
                    TextInput(
                          onSaved: (value) {
                        setState(() {
                          cost= value!;
                        });                       
                      }, validator: (value){
                        if(value!.isEmpty){
                          return "This field should not be empty..";
                        }
                      },
                      icon: Icons.receipt,
                      keyboardType: TextInputType.number,
                      label: "Cost 0f good",
                    ),
                   
                   const SizedBox(height: 20,),
                    TextInput(
                          onSaved: (value) {
                        setState(() {
                          price= value!;
                        });                       
                      }, validator: (value){
                        if(value!.isEmpty){
                          return "This field should not be empty..";
                        }
                      },
                      icon: Icons.payment_outlined,
                      keyboardType: TextInputType.number,
                      label: "Price",
                    ),
                    const SizedBox(height: 20,),
                    TextInput(
                          onSaved: (value) {
                        setState(() {
                          others= value!;
                        });                       
                      }, validator: (value){
                        if(value!.isEmpty){
                          return "This field should not be empty..";
                        }
                      },
                      icon: Icons.receipt,
                      keyboardType: TextInputType.number,
                      label: "Other expenses",
                    ),
                   const SizedBox(height: 20,),
                   
                    ImageInput(onPickImage: (image) {
                _selectedImage = image;
              }, ),
                  
                   const SizedBox(height: 20,),
                  ElevatedButton.icon(onPressed: _addProduct, icon: const Icon(Icons.add_shopping_cart_outlined), label: const Text("Add"))
                  
                  ],
                )  ,),
        ),
      ),
      

    );
  }
}