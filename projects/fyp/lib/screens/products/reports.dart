// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class GenerateReportsScreen extends StatefulWidget {
  const GenerateReportsScreen({super.key});

  @override
  State<GenerateReportsScreen> createState() => _GenerateReportsScreenState();
}

class _GenerateReportsScreenState extends State<GenerateReportsScreen> {
DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromRGBO(27,9,61,1.000),
        title: const Text("Generate Reports"),
      ),
      body: Container(
        width: 500,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(  
            begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            colors: [Color.fromRGBO(27,9,61,1.000),Color.fromRGBO(82,36,91,1.000),])
        ),
        child:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple.withOpacity(0.2),
        ),
        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'Start Date'
                                    : formatter.format(_selectedDate!),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),                                  
                                    // formatNumber(_selectedDate! as num?, formatType: FormatType.scientific),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(12),
          color: Colors.purple.withOpacity(0.2),
        ),
        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'End Date'
                                    : formatter.format(_selectedDate!),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),                                  
                                    // formatNumber(_selectedDate! as num?, formatType: FormatType.scientific),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
      ),
      ],),
                    
                  //   ],
                  // ),
        
        //     TextField(
        //   decoration: InputDecoration(
        //     label: const Text('Start Date')
        //   ),
        //   keyboardType: TextInputType.datetime,
        // ),
       const SizedBox(height: 19,),           
        ElevatedButton(onPressed: (){},
        style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.1)),), 
          child: const  Text("Generate",
          style: TextStyle(
          color: Colors.white
        ),
        ),
        ),
        
    
    ]),)  
    ));
     
    
  }
}