

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
   final _form = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredName= '';
  var _enteredEmail = '';
  var _enteredPassword = '';
  // var _isAuthenticating= false;

    void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
try{
  if(_isLogin){
    final UserCredential  userCredentials= await _firebase.signInWithEmailAndPassword(
      email: _enteredEmail, password: _enteredPassword);
      print(userCredentials);

  }
  else{
    final UserCredential userCredentials= await _firebase.createUserWithEmailAndPassword(
      email: _enteredEmail, password: _enteredPassword);
      print(userCredentials);
   DatabaseReference ref= FirebaseDatabase.instance.ref('users');
   await ref.set({
    "UserName": _enteredName,
    "userEmail": _enteredEmail,
   });
  }


} on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // ...
      }
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
          children:[ 
            Container(
              decoration: const BoxDecoration(
              color: Color.fromARGB(197, 219, 143, 203) , 
                borderRadius:  BorderRadius.only( 
                  bottomLeft: Radius.circular(19),
                  bottomRight: Radius.circular(19)
                  )
              ),
              height: 300,
              alignment: Alignment.center,
              child: const Image(
                image: AssetImage(
                  'assets/images/auth.png'
                  ),
                width: double.infinity,
                height: 200,  
                  )
            
             ),
            
          
         Container(
          padding: const EdgeInsets.only(top: 26) ,
           child: Center(
              child: Form(
                  key: _form,
                  child: SizedBox(
                  width: double.infinity,
                  height: 460,
                  child: ListView(
                    shrinkWrap: true,
                      padding: const EdgeInsets.all(30) ,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      if(!_isLogin)
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
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),
                                label: const Text("Name"),                                
                                filled: true,
                                fillColor: Colors.amber.shade100,
                                // fillColor: const Color.fromARGB(255, 236, 220, 162),
                                focusColor: Colors.blueGrey
                              ),
                              onSaved: (value){
                                  _enteredName= value!;
                              },
                                      
                            ),
                          ),
                        ),
                       const SizedBox(height: 10,),
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
                                fillColor: Colors.amber.shade100,
                                // fillColor: const Color.fromARGB(255, 236, 220, 162),
                                focusColor: Colors.blueGrey
                              ),
                              onSaved: (value){
                                  _enteredEmail= value!;
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
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(9.0)),
                                label: const Text("Password"),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 236, 220, 162),
                                focusColor: Colors.blueGrey
                              ),
                              obscureText: true,
                              onSaved: (value){
                                _enteredPassword= value!;
                              },
                                      
                            ),
                          ),
                        ),
                        const SizedBox(height: 12,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    // height: ,
                    child: ElevatedButton(
                            onPressed: _submit, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 142, 102, 153),
                              foregroundColor: Colors.amberAccent,
                              // padding: EdgeInsets.all(3.0)
                              // shape: const BeveledRectangleBorder()
                            ),
                            child: Text(_isLogin ? "Log in" :"Sign Up")
                            ),
                  ),
                      
                        const SizedBox(height: 20,),
                       TextButton(
                        onPressed: (){
                       setState(() {
                        _isLogin= !_isLogin; 
                       });
                       }, 
                         child: Text( _isLogin ? 
                         "Create a new Account.": 
                          "Already have an account?",
                         style:TextStyle(
                          color: Colors.amber
                         ),
                         ),
                       )
                      ],
                  
                  
                    ),
                ),
                
                ),
              ),
         ),
         
        ]
        )
      ),
    );
  }
}
