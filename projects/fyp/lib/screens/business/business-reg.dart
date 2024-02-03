import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/data/business.dart';
import 'package:fyp/widgets/UI/TextInput.dart';
import 'package:fyp/widgets/UI/drop-down.dart';
import 'package:uuid/uuid.dart';


FirebaseDatabase database = FirebaseDatabase.instance;

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() => _BusinessRegistrationScreenState();
}

class _BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {
  final _form = GlobalKey<FormState>();
//  List<dynamic> businesses= [
//     'Ecommerce',
//   'Restaurant', 'Textile', 'Bakers', 
// ];
    var _selectedBusiness= businesses.first;
    var _enteredBusinessName='';  

    void _register () async{
    final _isValid=  _form.currentState!.validate();
    if(!_isValid){
      return;
    }
    _form.currentState!.save();

    try{
        final user= FirebaseAuth.instance.currentUser;
        String uuid = const Uuid().v4();
        DatabaseReference ref= database.ref().child('shops');

       final data= await ref.child("S-$uuid").set({
            'shopId': 'S-$uuid',
            'name': _enteredBusinessName,
            'category': _selectedBusiness,
            'owner': user!.uid,
            
        });

       Navigator.of(context).pop();
         // ignore: use_build_context_synchronously
        //  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  ShopScreen(id: "S1", title: _selectedBusiness )));
    } on FirebaseException catch(error){
        print(error.message);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed.'),
        ),
      );
    }

    }
  @override
  Widget build(BuildContext context) {
  print('business=== $_selectedBusiness');
  return Scaffold(
     backgroundColor: Colors.purple[700] ,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: double.infinity,
                child: Image.asset('assets/images/business.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextInput(onSaved: (value){
                            _enteredBusinessName= value!;
                          }, label: "Your Businness Name"),
                          const SizedBox(height: 12),
                         
                          DropDown(value: _selectedBusiness, 
                          onChanged: (value){
                            setState(() {
                              _selectedBusiness=value!;
                            });
                          },
                          items: businesses, label: "Select Business Type"),      
                          ElevatedButton.icon(
                          onPressed: _register, 
                          icon: const Icon(Icons.app_registration_outlined), 
                          label: const Text("Register")),
                          
                          TextButton(
                            onPressed: () {
                            Navigator.of(context).pop();
                            },
                            child: const Text('skip')
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ); // clipBehavior: Clip.hardEd 
            
    
  }
}