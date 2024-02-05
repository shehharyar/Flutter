import 'dart:io';

import 'package:excel/excel.dart' as excel;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
final formatter = DateFormat.yMd();

class GenerateReportsScreen extends StatefulWidget {
  const GenerateReportsScreen({super.key});

  @override
  State<GenerateReportsScreen> createState() => _GenerateReportsScreenState();
}

class _GenerateReportsScreenState extends State<GenerateReportsScreen> {
DateTime? _selectedStartDate;
DateTime? _selectedEndDate;

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
      _selectedStartDate = pickedDate;
    });
    }
  void _endDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    
    setState(() {
      _selectedEndDate = pickedDate;
    });
  }
 final _salesReef= FirebaseDatabase.instance.ref().child('sales');

Future<void> _generateExcel() async {
  // Fetch data from Firebase based on selected dates
  if (_selectedStartDate != null && _selectedEndDate != null) {
    String startDateString =
        "${_selectedStartDate!.year}-${_addLeadingZero(_selectedStartDate!.month)}-${_addLeadingZero(_selectedStartDate!.day)}";
    String endDateString =
        "${_selectedEndDate!.year}-${_addLeadingZero(_selectedEndDate!.month)}-${_addLeadingZero(_selectedEndDate!.day)}";

    // Create Excel workbook and sheet
    final excelSheet = excel.Excel.createExcel();
    final sheet = excelSheet['SalesData'];

    // Add headers to the sheet
    sheet.appendRow([excel.TextCellValue("Timestamp") , excel.TextCellValue('Product'), excel.TextCellValue('Quantity'), 
    excel.TextCellValue('Price'), excel.TextCellValue('Profit')]);

    // Fetch data from Firebase
    await _salesReef.once().then((value) {
      if (value != null && value.snapshot.value != null) {
        Map<dynamic, dynamic>? salesData =
            value.snapshot.value as Map<dynamic, dynamic>;
        salesData!.forEach((key, value) {
          String timestamp = value['timestamp'];

          // Check if the timestamp is within the selected date range
          if (timestamp.compareTo(startDateString) >= 0 &&
              timestamp.compareTo(endDateString) <= 0) {
            // Iterate through items and add them to the Excel sheet
            for (var item in value['items']) {
              sheet.appendRow([
               excel.TextCellValue(timestamp.toString()),
                excel.TextCellValue(item['title'].toString()),
                excel.TextCellValue(item['quantity'].toString()),
                excel.TextCellValue(item['price'].toString()),
                excel.TextCellValue(item['profit'].toString())
              ]);
            }
          }
        });
      }
    });

    // Save Excel file to device storage
    // final excelPath = '/path/to/sales_report.xlsx';
    // final file = File(excelPath);
    // final file = File('${(await getTemporaryDirectory()).path}/sales.xlsx');

    // await file.writeAsBytes(excel.save());
var fileBytes = excelSheet.save();
// var directory = await getApplicationDocumentsDirectory();
Directory directory = await getApplicationDocumentsDirectory();
if (!await directory.exists()) {
  await directory.create(recursive: true);
}
var file= File(path.join("$directory/output_file_name.xlsx"))
  ..createSync(recursive: true)
  ..writeAsBytesSync(fileBytes!);

  print(file.path);
    // Once the file is saved, you can open it or perform any other necessary operations
 OpenFile.open(file.path);
 
  }
}



//  Future<void> _generateExcel() async {
//     // Fetch data from Firebase based on selected dates
//     if (_selectedStartDate != null && _selectedEndDate != null) {
      
//       String startDateString = "${_selectedStartDate!.year}-${_addLeadingZero(_selectedStartDate!.month)}-${_addLeadingZero(_selectedStartDate!.day)}";
//       String endDateString = "${_selectedEndDate!.year}-${_addLeadingZero(_selectedEndDate!.month)}-${_addLeadingZero(_selectedEndDate!.day)}";
      
//       print(endDateString);
//        await _salesReef.once().then((value) {
//             if (value != null && value.snapshot.value != null) {
//       Map<dynamic, dynamic>? salesData = value.snapshot.value as Map<dynamic, dynamic>;
//     //  print("RUNS");
//       salesData!.forEach((key, value) {
//         String timestamp = value['timestamp'];
//         // print(timestamp == yesterdayDate);
//         // print(currentDate);
//         // print(yesterdayDate);
//         for(var item in value['items']){
//           // print(item['profit']);
//         if (timestamp == startDateString) {
      
//         }}
//        });
//      } });

//     }
//   }

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
                                _selectedStartDate == null
                                    ? 'Start Date'
                                    : formatter.format(_selectedStartDate!),
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
                                _selectedEndDate == null
                                    ? 'End Date'
                                    : formatter.format(_selectedEndDate!),
                                  style: TextStyle(
                                    color: Colors.white
                                  ),                                  
                                    // formatNumber(_selectedDate! as num?, formatType: FormatType.scientific),
                              ),
                              IconButton(
                                onPressed: _endDatePicker,
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
        ElevatedButton(onPressed: _generateExcel,
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

      String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}

}