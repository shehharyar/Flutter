// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:fyp/model/product.dart';

class SalesDataTable extends StatefulWidget {
  const SalesDataTable({super.key, required this.shopId});
  final String shopId;
  @override
  State<SalesDataTable> createState() => _SalesDataTableState();
}

class _SalesDataTableState extends State<SalesDataTable> {
//  DatabaseReference data= FirebaseDatabase.instance.ref();    
 late DatabaseReference _data;
@override
  void initState() {
    super.initState();
    _data = FirebaseDatabase.instance.ref().child('sales');
  }
  @override
  Widget build(BuildContext context) {
       if (!_dataInitialized()) {
      return Center(child: CircularProgressIndicator());
    }
    
    return StreamBuilder(stream: _data.onValue, builder: ((context, snapshot) { 
       
       if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child:  CircularProgressIndicator(),
        );
       }
       
       final data = snapshot.data?.snapshot.value;
        if (data == null) {
          return Center(child: Text("No sales data available"));
        }


 final List<Map<Object?, Object?>> sales = [];
        final today = DateTime.now().toString().split(' ')[0]; // Get today's date

        (data as Map<dynamic, dynamic>).forEach((key, value) {
          final timeStamp = value['timestamp'].toString().split(' ')[0];
          for (var item in value['items']) {
            print(value['items'][0]['quantity'].runtimeType);
    if (timeStamp == today && item['shopId'] == widget.shopId) {
        final index = sales.indexWhere((sale) => sale['title'] == item['title']);
        print(item['quantity'].runtimeType);
        if (index != -1) {
              print(sales[index]['quantity'].runtimeType); 
            if (sales[index] == null) {
              // print("Sales");
             print( sales[index] != -1);
              // print(item['price']);
              // print("running");
              sales[index]['quantity'] = sales[index]['quantity'].toString() + item['quantity'];
              print(sales[index]['quantity']);
              //   // Update quantity, amount, and profit if the product is sold again
                if (item['quantity'] != null && item['quantity'] is num) {
                    sales[index]['quantity'] = sales[index]['quantity'].toString() + item['quantity'];
                }
                if (item['price'] != null) {
                    sales[index]['price'] =sales[index]['price'].toString() + item['price'];
                }
                if (item['profit'] != null && item['profit'] is int) {
                    sales[index]['profit'] = sales[index]['profit'].toString() + item['profit']; 
                    // sales[index]['profit']
                                    }
            }
        } else {
            // Add the product to the sales list
            sales.add(item);
        }
    }
}
          // Check if the sale is from today and the shopId matches
          
          // if (timeStamp == today && value['shopId'] == widget.shopId) {
          //   // Extract items and add the ID to each item
          //   List<dynamic> items = value['items'];
          //   items.forEach((item) {
          //     // Check if the same product is sold again
          //     final index = sales.indexWhere(
          //       (sale) => sale['id'] == item['id'],
          //     );
          //     if (index != -1) {
          //       // Update quantity, amount, and profit if the product is sold again
          //       sales[index]['quantity'] += item['quantity'];
          //       sales[index]['price'] += item['price'];
          //       sales[index]['profit'] += item['profit'];
          //     } else {
          //       // Add the product to the sales list
          //       sales.add(item);
          //     }
          //   });
          // }
        });




    //     final List<Map<Object?, Object?>> sales = [];
    //     (data as Map<dynamic, dynamic>).forEach((key, value) {

    //       print(value['timestamp']);
    //       // Check if the shopId matches
    //       for(var value in value['items'] ){
    //         if(value['shopId'] == widget.shopId){
    //                       sales.add(value);
    //       }
    //  } });

    //      if (value["items"] == widget.shopId && value['items'] != null) {
    //           // List<dynamic> items = value['items'].values.toList();
    //                       List<dynamic> items = value['items'];
    //                       print("items");
    //                       print(items);
    //           for (var item in items) {
    //   item['id'] = key;
    //   sales.add(Map<String, dynamic>.from(item)); // Add map instead of raw object
    // }
    // }
      // print("snapshot");
      // print(snapshot.data!.snapshot.children);
      // final sales= snapshot.data!.snapshot.value;
      //   print("Sales ==> ");
      //   print(sales);
      //   final List<dynamic> loadedSales = sales == null ? [] : List.from((data as Map<dynamic, dynamic>).values);
      
      // if(! snapshot.hasData ||  snapshot.data!.snapshot.value == null){
      //   return const Center( 
      //     child: Text("No Products added yet!.", style: TextStyle(color: Colors.deepOrange),),);
      // }
      // if(snapshot.hasError){
      //   return const Center(
      //     child: Text("Something went wrong!"),
      //   );
      // }
      print("Sales ==>");
     print(sales);

      
      return Expanded(
      
        child: Container(
  
          child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
            
                        headingTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        columns: const [
                        DataColumn(label: Text("S.NO.",)),
                        DataColumn(label: Text("Name",)),
                        DataColumn(label: Text("Qty",)),
                        DataColumn(label: Text("Amount",)),
                        DataColumn(label: Text("Profit",)),
                      ], 
                      rows: sales.map((product){
                                 final index = sales.indexOf(product);
                       return DataRow(
                        cells:[
                          DataCell(Center(
                            child: Text(
                              (index+1).toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent),
                              ),
                          )),
                          DataCell(Center(
                            child: Text(product['title'].toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent),
                            ),
                          )),
                          DataCell(Center(
                            child: Text(product['quantity'].toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent),
                            ),
                          )),
                          DataCell(Center(
                            child: Text(product['price'].toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent),
                            ),
                          )),
                          DataCell(Center(
                            child: Text(product['profit'].toString(),
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.amberAccent),
                            ),
                          )),
                        ] );
                      }).toList(),
                      
                      ),
                      
                  ),
        ),
        
      );
         

    }));
  }
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
}  
  bool _dataInitialized() {
   return _data != null;
  }
}

