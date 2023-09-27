// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:play_ground/screens/new_catalog.dart';

class BusinessRegistrationScreen extends StatefulWidget{
 const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() => _BusinessRegistrationScreenState();
}

class _BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {
    final _formKey = GlobalKey<FormState>();
    static const List<String> categories= [ "E-Commerce", "Restaurant"];
  @override
  Widget build(BuildContext context) {
   return   Scaffold(
    body: SingleChildScrollView(
      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
      padding: const EdgeInsets.only(top: 20.0),
      child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                Text(
              "Register Your Business",
              style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.normal,
                      fontSize: 30,
                      color: Colors.blue),
                ),
                const SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    decoration:  InputDecoration( 
                      labelText: "Name of Business",
                      labelStyle: const TextStyle(
                        color: Colors.blue                      
                        ),
                      border:  OutlineInputBorder(borderSide: BorderSide(
                        width: 1.0,
                        color: Theme.of(context).colorScheme.onBackground
                      ))
                     ),
                     onSaved: (newValue) {
                       
                     },
                  ),
                ),

                  // const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Expanded(
                      child: DropdownButtonFormField(
                       decoration:  InputDecoration( 
                        labelText: "Select Business Type",
                        labelStyle: const TextStyle(
                          color: Colors.blue                      
                          ),
                        border:  OutlineInputBorder(borderSide: BorderSide(
                          width: 1.0,
                          color: Theme.of(context).colorScheme.onBackground
                        ))
                       ),
                        items: [
                          for (final category in categories)
                            DropdownMenuItem(
                              
                              value: category,
                              child: 
                                  Text(category,
                                  style: const TextStyle( color: Colors.amberAccent ),
                                  ),
                              
                            ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewCatalogScreen() ));
                      } , 
                      child: Text("Register"), 
                      style:  ButtonStyle(
                        padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    ),
                      ),
                      ),
                    )
              ],
            ))
        
      ),
    
   );   
  }
}