import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class SalesTotalWigets extends StatefulWidget {
  const SalesTotalWigets({super.key});

  @override
  State<SalesTotalWigets> createState() => _SalesTotalWigetsState();
}

class _SalesTotalWigetsState extends State<SalesTotalWigets> {
 late DatabaseReference _data;
  double todaySalesTotal = 0;
  double yesterdaySalesTotal = 0;

  @override
  void initState() {
    super.initState();
     _data = FirebaseDatabase.instance.ref().child('sales');

  }
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(stream: _data.onValue, builder: ((context, snapshot) { 
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }   
      print(snapshot);
        
    
    return ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                      borderRadius: BorderRadius.circular(27),
                      color: Colors.white.withOpacity(0.2),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('\$ $todaySalesTotal'.toString(), style: TextStyle(fontSize: 45, color: Colors.white)),
                          Text("Today", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                      borderRadius: BorderRadius.circular(27),
                      color: Colors.white.withOpacity(0.2),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('\$ $yesterdaySalesTotal'.toString(), style: TextStyle(fontSize: 45, color: Colors.white)),
                          Text("Yesterday", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
        }));
    // return StreamBuilder(stream: _data.onValue, builder: ((context, snapshot) {
    //   if(snapshot.connectionState == ConnectionState.waiting) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   } 
    // }));

  }
}