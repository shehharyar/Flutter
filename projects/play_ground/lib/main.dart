import 'package:flutter/material.dart';
// import 'package:play_ground/screens/authSignUp.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:play_ground/models/data.dart';
// import 'package:play_ground/screens/Catalog.dart';
import 'package:play_ground/screens/business-reg.dart';
// import 'package:play_ground/screens/new_catalog.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: "Playground App",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 69, 129, 199),
          )
          ,
          textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
      ),
      home: const BusinessRegistrationScreen()
      
      // const CatalogScreen(catalogs: dummyCatalogs),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Playground App"),
//         ),
//         body:  CatalogScreen(dummyCatalogs),
//         // body: const Signup(),
//         );
//   }
// }
