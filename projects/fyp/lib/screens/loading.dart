import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 120),
              decoration: const BoxDecoration(
              color: Color.fromARGB(197, 231, 165, 217) , 
                borderRadius:  BorderRadius.only( 
                  bottomLeft: Radius.circular(19),
                  bottomRight: Radius.circular(19)
                  )
              ),
              height: 300,
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.amber,),
          )
        ],
      ),
    );
  }
}