import 'package:flutter/material.dart';

class SalesDashboard extends StatelessWidget {
  const SalesDashboard({super.key});

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
           Expanded(
            
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14,),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      
                    )
                    ,
                    child: const Text("Recors...",
                  
                    style: TextStyle(
                      fontSize: 25,
                      color: 
                  
                    Colors.white),
                    ),
                  ),
                ]),
            )

          ],
        )
      )
    );
  }
}