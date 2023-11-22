import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/auth/auth.dart';
import 'package:fyp/screens/loading.dart';
import 'package:fyp/screens/shop/create-shop.dart';

import 'firebase_options.dart';
void main() async {  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      
        useMaterial3: true,
        
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingScreen();
        }
        if(snapshot.hasData){
          return const CreateShopScreen();
        }
        return const AuthScreen();
      })
    );
  }
}
