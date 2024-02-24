
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/payments/totalPayments.dart';

 DatabaseReference data= FirebaseDatabase.instance.ref();

class PaymentScreen extends StatefulWidget {
 const PaymentScreen({super.key, required this.shopId});
  final String shopId;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}
class _PaymentScreenState extends State<PaymentScreen> {
  late DatabaseReference _data;
  double todaySalesTotal = 0;
  double yesterdaySalesTotal = 0;

  @override
  void initState() {
    super.initState();
     _data = FirebaseDatabase.instance.ref().child('sales');

  }

  double calculateTotal(List<dynamic> items) {
    double total = 0.0;
    for (var item in items) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }



  @override
  Widget build(BuildContext context) {
 
return Scaffold(
  body: SingleChildScrollView(
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(27, 9, 61, 1.000), Color.fromRGBO(82, 36, 91, 1.000)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.8, // Adjust height as needed
            child: PaymentTotalWigets(shopId: widget.shopId),
          ),
          const SizedBox(height: 25),
          // Add more widgets here if needed
        ],
      ),
    ),
  ),
);

  }}
// class _SalesDashboardState extends State<SalesDashboard> {
// late   DatabaseReference _data ;
//   double todaySalesTotal = 0;
//   double yesterdaySalesTotal = 0;

//   @override
//   void initState() {
//     super.initState();
//     _data= = FirebaseDatabase.instance.ref().child('sales');
//     fetchSalesData();
//   }
// double calculateTotal(List<dynamic> items) {
//   double total = 0.0;
//   for (var item in items) {
//     total += item['price'] * item['quantity'];
//   }
//   return total;
// }


//   void fetchSalesData() {
//     final currentDate = DateTime.now();
//     final yesterdayDate = currentDate.subtract(const Duration(days: 1));

//     final currentDateString = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
//     final yesterdayDateString = "${yesterdayDate.year}-${yesterdayDate.month}-${yesterdayDate.day}";
// StreamBuilder(
//   stream: _data.orderByChild('shopId').equalTo(widget.shopId).onValue,
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (snapshot.hasError) {
//       return Center(child: Text('Error: ${snapshot.error}'));
//     }

//     if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
//       return Center(child: Text('No sales data available'));
//     }

//     // Extract sales data
//     Map<dynamic, dynamic>? salesData = snapshot.data!.snapshot.value as Map?;

//     // Calculate today's and yesterday's sales totals
//     double todayTotal = 0.0;
//     double yesterdayTotal = 0.0;

//     final currentDate = DateTime.now();
//     final yesterdayDate = currentDate.subtract(Duration(days: 1));

//     final currentDateString = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
//     final yesterdayDateString = "${yesterdayDate.year}-${yesterdayDate.month}-${yesterdayDate.day}";

//     salesData!.forEach((key, value) {
//       String timestamp = value['timestamp'];

//       if (timestamp == currentDateString) {
//         todayTotal += calculateTotal(value['items']);
//       } else if (timestamp == yesterdayDateString) {
//         yesterdayTotal += (value['items']);
//       }
//     });

//   });





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sales"),
//         foregroundColor:Colors.white,
//         backgroundColor: const Color.fromRGBO(27,9,61,1.000),
//       ),
//       body:Container(
//         width: double.infinity,
//         height: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(  
//             begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//             colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
//         ),
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 200,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 12),
//                           decoration:  BoxDecoration(
//                                   border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
//                                   borderRadius: BorderRadius.circular(27),
//                                   color: Colors.white.withOpacity(0.2),
//                                   gradient:const  LinearGradient(
//                                     begin: Alignment.topRight,
//                                     end: Alignment.topLeft,
//                                     colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
//                                 ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
                          
//                           Text('\$ $todaySalesTotal'.toString(),
//                           style: TextStyle(
//                             fontSize: 45,
//                             color: Colors.white,
//                            ),
//                           ),
//                           Text("Today",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
                            
//                             fontSize: 20,
//                             color: Colors.white,
//                            ),
//                           ),
//                         ],
//                       ),
//                     ) ,
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 12),
//                           decoration:  BoxDecoration(
//                                   border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
//                                   borderRadius: BorderRadius.circular(27),
//                                   color: Colors.white.withOpacity(0.2),
//                                   gradient:const  LinearGradient(
//                                     begin: Alignment.topRight,
//                                     end: Alignment.topLeft,
//                                     colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
//                                 ),
//                     child:const Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           Text("\$ +45,000",
//                           style: TextStyle(
//                             fontSize: 45,
//                             color: Colors.white,
//                            ),
//                           ),
//                           Text("Yesterday",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
                            
//                             fontSize: 20,
//                             color: Colors.white,
//                            ),
//                           ),
//                         ],
//                       ),
//                     ) ,
//                   )
//                 ],
//               ),
//             ),
//          const SizedBox(height: 25,),
//           SalesDataTable(shopId: widget.shopId),

//           ],
//         )
//       )
//     );
//   }
//   }} 


  
