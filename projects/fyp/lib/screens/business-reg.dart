import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/data/business.dart';
import 'package:fyp/screens/NewShop.dart';


FirebaseDatabase database = FirebaseDatabase.instance;

class BusinessRegistrationScreen extends StatefulWidget {
  const BusinessRegistrationScreen({super.key});

  @override
  State<BusinessRegistrationScreen> createState() => _BusinessRegistrationScreenState();
}

class _BusinessRegistrationScreenState extends State<BusinessRegistrationScreen> {
  final _form = GlobalKey<FormState>();
    var _selectedBusiness = businesses.first;
    var _enteredBusinessName='';  

    void _register () async{
    final _isValid=  _form.currentState!.validate();
    if(!_isValid){
      return;
    }
    _form.currentState!.save();

    try{
        final user= FirebaseAuth.instance.currentUser;
        DatabaseReference ref= database.ref('businesses');
        await ref.set({
            'name': _enteredBusinessName,
            'category': _selectedBusiness,
            'owner': user!.uid
        }).then((value) => 
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewShopScreen() ))
        ).catchError((error)=>{
          
        });


    } on FirebaseException catch(error){
        
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
    return Scaffold(
     backgroundColor: Colors.purple[700] ,
      
      body: SingleChildScrollView(
        child: Column(
          children: [
                Container(
                padding: const EdgeInsets.only(top: 120),
                decoration: const BoxDecoration(
                color: Color.fromARGB(197, 219, 143, 203) , 
                  borderRadius:  BorderRadius.only( 
                    bottomLeft: Radius.circular(19),
                    bottomRight: Radius.circular(19)
                    )
                ),
                height: 300,
                alignment: Alignment.topCenter,
                  
                    child: const Text("Register Your Business",
                    style: TextStyle(
                          decorationStyle: TextDecorationStyle.wavy,
                          backgroundColor: Color.fromARGB(189, 99, 67, 96),
                          color: Color.fromARGB(255, 255, 254, 251),
                          fontStyle: FontStyle.italic,
                          fontSize: 25.0,
                          
                    ),
                    ),
                   
               ),
                 // clipBehavior: Clip.hardEdge,
            
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: Center(
              child: Form(
                  key: _form,
                  child: 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width:2.0, 
                        color: Colors.white10,
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),
                              label: const Text("Email"),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 236, 220, 162),
                              focusColor: Colors.blueGrey
                            ),
                            onSaved: (value){
                              _enteredBusinessName= value!;
                                // _enteredEmail= value!;
                            },
                                    
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width:2.0, 
                        color: Colors.white10,
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: DropdownButtonFormField(
                            dropdownColor: const Color.fromARGB(255, 236, 220, 162),
                            value: _selectedBusiness,
                            
                            items: [
                              for( var business in businesses)
                                DropdownMenuItem(
                                  value: business,
                                  child: Text(business))
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),
                              label: const Text("-- Select Business Type --"),
                            
                              filled: true,
                              fillColor: const Color.fromARGB(255, 236, 220, 162),
                              focusColor: Colors.blueGrey
                            ),
                            
                            onChanged: (value){
                              setState(() {
                              _selectedBusiness= value!;  
                              });
                              // _enteredPassword= value!;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 12,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 142, 102, 153),
                        foregroundColor: Colors.amberAccent
                      ),
                      onPressed:(){} //_submit, 
                      ,child: Text('Register')
                      ),
                      const SizedBox(height: 20,),
                     TextButton(
                      onPressed: (){
                            FirebaseAuth.instance.signOut();
                     }, 
                       child: const Text( "Skip",
                       style:TextStyle(
                        color: Colors.amber
                       ),
                       ),
                     )
                    ],
                
                
                  ),
                )
                ),
              ),
            ),
          ]
        ),
      ),  
    );
  }
}