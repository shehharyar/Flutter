import 'package:flutter/material.dart';
// import 'package:play_ground/models/Catalog.dart';

class NewCatalogScreen extends StatefulWidget{
  const NewCatalogScreen( {super.key});

  @override
  State<NewCatalogScreen> createState() => _NewCatalogScreenState();
}


class _NewCatalogScreenState extends State<NewCatalogScreen>{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("") 
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
               Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: '',
                    onSaved: (value) {
                      // user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.add_shopping_cart_sharp,
                          color: Colors.blue,
                        ),
                        hintText: 'Name of Product',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const  BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: '',
                    onSaved: (value) {
                      // user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.key,
                          color: Colors.blue,
                        ),
                        hintText: 'Code',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const  BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: '',
                    onSaved: (value) {
                      // user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.money,
                          color: Colors.blue,
                        ),
                        hintText: 'Price',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const  BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    initialValue: '',
                    onSaved: (value) {
                      // user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    decoration: InputDecoration(
                        icon: const Icon(
                          Icons.woo_commerce,
                          color: Colors.blue,
                        ),
                        hintText: 'C.O.G.',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const  BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField(items: const [
                    DropdownMenuItem(
                      child:  Text("Item -1") )
                  ],
                    decoration:  InputDecoration(
                          icon: const Icon(
                          Icons.price_change_outlined,
                          color:  Colors.blue,
                        ),
                        hintText: 'Other Expenses.',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide:  BorderSide(color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue)),
                    ),
                   onChanged:  (value) {
                        setState(() {
                          // _selectedCategory = value!;
                        });
  }
  ),
                ),

                Padding(        
                  padding: const EdgeInsets.all(29.0),
                  child: OutlinedButton(
                    onPressed: () {},
                     
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).buttonTheme.colorScheme!.primary,
                      shape:  RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(8))),
                      side: const BorderSide(width: 2, color: Colors.blue),
                           padding: const EdgeInsets.all(18.0)
                      ),
                    child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add"),
                            Icon(Icons.add)
                          ],),
                      
                    
                    ),
                )                
              ],
            ),
          ),
        ),
    );


}
}