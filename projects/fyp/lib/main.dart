import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/screens/auth/auth.dart';
import 'package:fyp/screens/shop/create-shop.dart';

import 'firebase_options.dart';
void main() async {  
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    const    ProviderScope(child:  MyApp()));
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
      home: SplashScreen(),
   
    );
  }
}
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      
//         useMaterial3: true,
        
//       ),
//       home: 
//       StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, snapshot){
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return const LoadingScreen();
//         }
//         if(snapshot.hasData){
//           return const CreateShopScreen();
//         }
//         return const AuthScreen();
//       })
//     );
//   }
// }

 
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeAppAndNavigate();
  }

  Future<void> initializeAppAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate a delay for the splash screen

    // Check authentication state and navigate accordingly
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const CreateShopScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // You can customize your splash screen UI here
    return  Container(
              width: 500,
          height:double.infinity,
           decoration: const  BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
        child: Center(
        child: Image.asset('assets/images/swift.png',
        fit: BoxFit.cover,
        )
        ));
  }
}