

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/widgets/UI/TextInput.dart';

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
      // backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
              width: 500,
          height:double.infinity,
           decoration: const  BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
        child: Center(
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
                width: 200,
                child: Image.asset('assets/images/auth.png'),
              ),
              Card(
                borderOnForeground: true,
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                         if(!_isLogin)
                          TextInput(onSaved: (value){
                            _enteredName= value!;
                          }, label: "User Name",
                          validator: (value){
                            if(value!.isEmpty){
                              return "User Name must be provided.";
                            }
                            if(value.length < 3){
                              return "Name should be of 3 Alphabets or more";
                            }
                          },
                          icon: Icons.person_pin_outlined,
                          ),
                         

                          TextInput(
                            label:"Email Address",
                            icon: Icons.email_outlined,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _enteredEmail = value!;
                            },
                          ),
                               TextInput(onSaved: (value){
                            
                            _enteredPassword= value!;
                          },
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            icon: Icons.password_outlined,
                            obsecureText: true,
                           label: "Password"),
                          // TextFormField(
                          //   decoration:
                          //       const InputDecoration(labelText: 'Password'),
                          //   obscureText: true,
                          //   validator: (value) {
                          //     if (value == null || value.trim().length < 6) {
                          //       return 'Password must be at least 6 characters long.';
                          //     }
                          //     return null;
                          //   },
                          //   onSaved: (value) {
                          //     _enteredPassword = value!;
                          //   },
                          // ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: const Color.fromARGB(255, 52, 25, 100),
                            ),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(_isLogin
                                ? 'Create an account'
                                : 'I already have an account',
                                
                                ),
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
      ))
    );
    // return Scaffold(

    //   backgroundColor: Colors.purple[700] ,
      
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children:[ 
    //         Container(
    //           decoration: const BoxDecoration(
    //           color: Color.fromARGB(197, 219, 143, 203) , 
    //             borderRadius:  BorderRadius.only( 
    //               bottomLeft: Radius.circular(19),
    //               bottomRight: Radius.circular(19)
    //               )
    //           ),
    //           height: 300,
    //           alignment: Alignment.center,
    //           child: const Image(
    //             image: AssetImage(
    //               'assets/images/auth.png'
    //               ),
    //             width: double.infinity,
    //             height: 200,  
    //               )
            
    //          ),
            
          
    //      Container(
    //       padding: const EdgeInsets.only(top: 26) ,
    //        child: Center(
    //           child: Form(
    //               key: _form,
    //               child: ListView(
    //                 shrinkWrap: true,
    //                   padding: const EdgeInsets.all(30) ,
    //                   //mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                   if(!_isLogin)
    //                      Container(
    //                        decoration: BoxDecoration(
                      
    //                         border: Border.all(
    //                           width:2.0, 

    //                       color: Colors.white10,
    //                         )
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(2.0),
    //                         child: TextFormField(
    //                           keyboardType: TextInputType.name,
    //                           decoration: InputDecoration(hintText: "Name",
    //                    prefixIcon: const Icon(Icons.phone_outlined, size: 18),
    //                    contentPadding: const EdgeInsets.all(12),
    //                    floatingLabelBehavior: FloatingLabelBehavior.never,
    //                    hintStyle: TextStyle(
    //                               fontSize: 14,
    //                               color: Colors.deepPurple[700]),
    //                               border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
    //                                     enabledBorder: OutlineInputBorder(
    //                                         borderSide: const BorderSide(color: Colors.transparent),
    //                                         borderRadius: BorderRadius.circular(10)),
    //                                     filled: true,
    //                                     fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
    //                                   ),
              
    //                           onSaved: (value){
    //                               _enteredName= value!;
    //                           },
                                      
    //                         ),
    //                       ),
    //                     ),
    //                    const SizedBox(height: 10,),
    //                     Container(
    //                       decoration: BoxDecoration(
                      
    //                         border: Border.all(
    //                           width:2.0, 

    //                       color: Colors.white10,
    //                         )
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(2.0),
    //                         child: TextFormField(
    //                           decoration: InputDecoration(hintText: "Email",
    //                    prefixIcon: const Icon(Icons.mail_outline, size: 18),
    //                    contentPadding: const EdgeInsets.all(12),
    //                    floatingLabelBehavior: FloatingLabelBehavior.never,
    //                    hintStyle: TextStyle(
    //                               fontSize: 14,
    //                               color: Colors.deepPurple[700]),
    //                               border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
    //                                     enabledBorder: OutlineInputBorder(
    //                                         borderSide: const BorderSide(color: Colors.transparent),
    //                                         borderRadius: BorderRadius.circular(10)),
    //                                     filled: true,
    //                                     fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
    //                                   ),
              
    //                           onSaved: (value){
    //                               _enteredEmail= value!;
    //                           },
                                      
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(height: 12,),
    //                     Container(
    //                       decoration: BoxDecoration(
    //                         border: Border.all(
    //                           width:2.0, 
    //                       color: Colors.white10,
    //                         )
    //                       ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(2.0),
    //                         child: TextFormField(
    //                           decoration: InputDecoration(hintText: "Password",
    //                    prefixIcon: const Icon(Icons.password_outlined, size: 18),
    //                    contentPadding: const EdgeInsets.all(12),
    //                    floatingLabelBehavior: FloatingLabelBehavior.never,
    //                    hintStyle: TextStyle(
    //                               fontSize: 14,
    //                               color: Colors.deepPurple[700]),
    //                               border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
    //                                     enabledBorder: OutlineInputBorder(
    //                                         borderSide: const BorderSide(color: Colors.transparent),
    //                                         borderRadius: BorderRadius.circular(10)),
    //                                     filled: true,
    //                                     fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
    //                                   ),
              
    //                           obscureText: true,
    //                           onSaved: (value){
    //                             _enteredPassword= value!;
    //                           },
                                      
    //                         ),
    //                       ),
    //                     ),
    //                     const SizedBox(height: 12,),
    //                                ElevatedButton.icon(onPressed: _submit, icon: const Icon(Icons.add_shopping_cart_outlined), label: const Text("Add")),
 
                  
                      
    //                     const SizedBox(height: 20,),
    //                    TextButton(
    //                     onPressed: (){
    //                    setState(() {
    //                     _isLogin= !_isLogin; 
    //                    });
    //                    }, 
    //                      child: Text( _isLogin ? 
    //                      "Create a new Account.": 
    //                       "Already have an account?",
    //                      style:TextStyle(
    //                       color: Colors.amber
    //                      ),
    //                      ),
    //                    )
    //                   ],
                  
                  
    //                 ),
                
                
    //             ),
    //           ),
    //      ),
         
    //     ]
    //     )
    //   ),
    // );
  }
}
