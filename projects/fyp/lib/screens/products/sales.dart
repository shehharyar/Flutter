import 'package:flutter/material.dart';

class SalesDashboard extends StatelessWidget {
  SalesDashboard({super.key});

final List<Map<String, String>> _products =[
      {"S.No": "1", "Name": "Burger", "Quantity": "3", "Amount": "25.09", "Profit": "12" },
      {"S.No": "2", "Name": "Fries", "Quantity": "2", "Amount": "15.09", "Profit": "12" },
      {"S.No": "3", "Name": "Pizza", "Quantity": "4", "Amount": "35.09", "Profit": "12" },
      {"S.No": "4", "Name": "Sandwich", "Quantity": "6", "Amount": "29.09", "Profit": "12" },
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales"),
        foregroundColor:Colors.white,
        backgroundColor: const Color.fromRGBO(27,9,61,1.000),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration:  BoxDecoration(
                                  border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                                  borderRadius: BorderRadius.circular(27),
                                  color: Colors.white.withOpacity(0.2),
                                  gradient:const  LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft,
                                    colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
                                ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          
                          Text("\$ +45,000",
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                           ),
                          ),
                          Text("Today",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            
                            fontSize: 20,
                            color: Colors.white,
                           ),
                          ),
                        ],
                      ),
                    ) ,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                          decoration:  BoxDecoration(
                                  border: Border.all(color: Color.fromARGB(0, 40, 23, 71)),
                                  borderRadius: BorderRadius.circular(27),
                                  color: Colors.white.withOpacity(0.2),
                                  gradient:const  LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft,
                                    colors: [Color.fromARGB(255, 44, 6, 116), Color.fromARGB(255, 12, 4, 18)])
                                ),
                    child:const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("\$ +45,000",
                          style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                           ),
                          ),
                          Text("Yesterday",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            
                            fontSize: 20,
                            color: Colors.white,
                           ),
                          ),
                        ],
                      ),
                    ) ,
                  )
                ],
              ),
            ),
         const SizedBox(height: 25,),
      _products.isEmpty ? const Center(child: Text("No products sold today"),) :   Expanded(
            
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
                rows: _products.map((product){
                 return DataRow(
                  cells:[
                    DataCell(Center(
                      child: Text(
                        product['S.No'].toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent),
                        ),
                    )),
                    DataCell(Center(
                      child: Text(product['Name'].toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(product['Quantity'].toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(product['Amount'].toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(product['Profit'].toString(),
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.amberAccent),
                      ),
                    )),
                  ] );
                }).toList(),
                
                ),
                ),
            )

          ],
        )
      )
    );
  }
}