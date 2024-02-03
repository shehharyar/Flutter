import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:myapp/screens/auth/auth_Sgn_in.dart';
import '';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "AIzaSyD3WLgObBQtZ60Mk8I9DME5bV7A3ThZluA", 
  appId: "1:567847033454:android:b3aa4dfd9a7fd92f11e47f", 
  messagingSenderId: "567847033454", 
  projectId: "flutter-1b794")
): await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 MyApp({super.key});
  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#5AD3BC');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Playground App",
        theme: ThemeData(
          primaryColor: _primaryColor,
          scaffoldBackgroundColor: Colors.grey[100],
          primarySwatch: Colors.grey,
          colorScheme: ColorScheme.fromSeed(
            secondary: _accentColor,
            brightness: Brightness.light,
            seedColor: const Color.fromARGB(255, 69, 129, 199),
          ),
          textTheme: GoogleFonts.latoTextTheme(),
          useMaterial3: true,
        ),
        home: Builder(builder: (BuildContext context) {
          final screenHeight = MediaQuery.of(context).size.height;
          return Login(screenHeight: screenHeight);
        })
        // const CatalogScreen(catalogs: dummyCatalogs),
        );
  }
}