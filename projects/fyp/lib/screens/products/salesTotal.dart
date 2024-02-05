// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// class SalesTotalWigets extends StatefulWidget {
//   const SalesTotalWigets({super.key});

//   @override
//   State<SalesTotalWigets> createState() => _SalesTotalWigetsState();
// }

// class _SalesTotalWigetsState extends State<SalesTotalWigets> {
//  late DatabaseReference _data;
//   double todaySalesTotal = 0;
//   double yesterdaySalesTotal = 0;

//   @override
//   void initState() {
//     super.initState();
//      _data = FirebaseDatabase.instance.ref().child('sales');

//   }
//   @override
//   Widget build(BuildContext context) {

//     return StreamBuilder(stream: _data.onValue, builder: ((context, snapshot) { 
//         if(snapshot.connectionState == ConnectionState.waiting){
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }   
//        final data = snapshot.data?.snapshot.value;

//         print('salesTotal');
//       print(snapshot.data!.snapshot.value);
// final List<Map<Object?, Object?>> sales = [];
//         final today = DateTime.now().toString().split(' ')[0]; // Get today's date

//     (data as Map<dynamic, dynamic>).forEach((key, value) { 
//       print('Data Values ==> ');
//       print(value);
//       for (var item in value){
       
//       } 
//     });        
    
//     return ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
//                       borderRadius: BorderRadius.circular(27),
//                       color: Colors.white.withOpacity(0.2),
//                       gradient: const LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.topLeft,
//                         colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)],
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('\$ $todaySalesTotal'.toString(), style: TextStyle(fontSize: 45, color: Colors.white)),
//                           Text("Today", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
//                       borderRadius: BorderRadius.circular(27),
//                       color: Colors.white.withOpacity(0.2),
//                       gradient: const LinearGradient(
//                         begin: Alignment.topRight,
//                         end: Alignment.topLeft,
//                         colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)],
//                       ),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text('\$ $yesterdaySalesTotal'.toString(), style: TextStyle(fontSize: 45, color: Colors.white)),
//                           Text("Yesterday", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//         }));
//     // return StreamBuilder(stream: _data.onValue, builder: ((context, snapshot) {
//     //   if(snapshot.connectionState == ConnectionState.waiting) {
//     //     return const Center(
//     //       child: CircularProgressIndicator(),
//     //     );
//     //   } 
//     // }));

//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SalesTotalWigets extends StatefulWidget {
  const SalesTotalWigets({Key? key, required this.shopId}) : super(key: key);
  final String shopId;
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
    fetchSalesData();
  }

  double calculateTotal(List<dynamic> items) {
    double total = 0.0;
    for (var item in items) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }
  void fetchSalesData() {
 final today = DateTime.now(); // Get today's date
  final currentDate = "${today.year}-${_addLeadingZero(today.month)}-${_addLeadingZero(today.day)}";

  final yesterday = today.subtract(const Duration(days: 1));
  final yesterdayDate = "${yesterday.year}-${_addLeadingZero(yesterday.month)}-${_addLeadingZero(yesterday.day)}";

//             final today = DateTime.now(); // Get today's date

//   final currentDate =DateTime.now().toString().split(' ')[0]; // Get today's date

//   final yesterday = today.subtract(const Duration(days: 1));
// final yesterdayDate= yesterday.toString().split('')[0];
  // final currentDateString = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
  // final yesterdayDateString = "${yesterdayDate.year}-${yesterdayDate.month}-${yesterdayDate.day}";

  _data.once().then((snapshot) {
    if (snapshot != null && snapshot.snapshot.value != null) {
      Map<dynamic, dynamic>? salesData = snapshot.snapshot.value as Map<dynamic, dynamic>;
    //  print("RUNS");
      salesData!.forEach((key, value) {
        String timestamp = value['timestamp'];
        // print(timestamp == yesterdayDate);
        // print(currentDate);
        // print(yesterdayDate);
        for(var item in value['items']){
          // print(item['profit']);
        if (timestamp == currentDate) {
      
          todaySalesTotal += double.tryParse(item['profit'].toString()) ?? 0.0;

        } else if (timestamp == yesterdayDate) {
      // print("yester");
          yesterdaySalesTotal += double.tryParse(item['profit'].toString()) ?? 0.0;
      
        }
        }
      });
      setState(() {}); // Update the UI with the calculated totals
    }
  }).catchError((error) {
    print('Error fetching sales data: $error');
  });
}

// void fetchSalesData() {
//   final currentDate = DateTime.now();
//   final yesterdayDate = currentDate.subtract(const Duration(days: 1));

//   final currentDateString = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
//   final yesterdayDateString = "${yesterdayDate.year}-${yesterdayDate.month}-${yesterdayDate.day}";
//   _data.once().then((value) {
//     print(value.snapshot.value);
//     if (value != null && value.snapshot.value != null) {
//       // Map<dynamic, dynamic> salesData = {};
//       if (value.snapshot.value is Map) {
//        Map<dynamic, dynamic>? salesData = value.snapshot.value as Map<dynamic, dynamic>;
//   salesData.forEach((key, value) {
//     String timestamp = value['timestamp'];
//     double profit = double.parse(value['profit']!); // Assuming profit is a string
//    if (timestamp == currentDateString) {
//           todaySalesTotal += double.tryParse(value['profit'].toString()) ?? 0.0;
//         } else if (timestamp == yesterdayDateString) {
//           yesterdaySalesTotal += double.tryParse(value['profit'].toString()) ?? 0.0;
//         }
//         });
//         // setState(() {}); // Update the UI with the calculated totals
//       }
//       print('Yesterday==>  $yesterdaySalesTotal');
//     }
//   }).catchError((error) {
//     print('Error fetching sales data: $error');
//   });
// }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildSalesCard("Today", todaySalesTotal.toStringAsFixed(2)),
        _buildSalesCard("Yesterday", yesterdaySalesTotal.toStringAsFixed(2)),
      ],
    );
  }

  Widget _buildSalesCard(String title, String amount) {
    return Container(
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
            Text('\$ $amount', style: TextStyle(fontSize: 45, color: Colors.white)),
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}

}
