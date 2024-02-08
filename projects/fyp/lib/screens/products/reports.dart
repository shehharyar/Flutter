// import 'dart:html';
import 'dart:io';

// import 'package:excel/excel.dart' as excel;
// import 'package:excel/excel.dart' as wb;


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
// import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as wb;
final formatter = DateFormat.yMd();

class GenerateReportsScreen extends StatefulWidget {
  const GenerateReportsScreen({super.key, required this.shopId});
  final String shopId;
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

Future<void> generateExcelSheet(DateTime startDate, DateTime endDate) async {
  DatabaseReference _salesRef = FirebaseDatabase.instance.ref().child('sales');
  List<Map<String, dynamic>> salesData = [];

  try {
    // Fetch sales data between specified dates
    await _salesRef.once().then((snapshot) async {

    if (snapshot.snapshot.value != null) {
  print(snapshot.snapshot.value);     
  print(snapshot.snapshot.value.runtimeType);     
      Map<dynamic, dynamic> salesMap = snapshot.snapshot.value as Map;
      print(salesMap);
      print(salesMap.runtimeType);
      salesMap.forEach((key, value){
       
      //  final beginDate = '${startDate.year}-${_addLeadingZero(startDate.month)}-${_addLeadingZero(startDate.day)}';
       final String salesDate= value['timestamp'];
       DateTime saleDate= DateTime.parse(salesDate);

      //  print('begin Date:  ${beginDate}');
       print(endDate);
        print("Value from sales === $value");
        print(value['items'][0]['price']);
    for (var item in value['items']){
      print('Item in for-in loop : $item');
  print('Condition: ${saleDate.isAfter(startDate)}');
   if (saleDate.isAfter(startDate) && saleDate.isBefore(endDate) || saleDate == endDate) {
          if(item['shopId'] == widget.shopId){
            print("Shop Matched");
          salesData.add({
            'title':item['title'],
            'price':item['price'],
            'quantity':item['quantity'],
            'profit':item['profit'],
            'Date':salesDate,
          });
          }
        }
    }
  print('salesData between $startDate & $endDate : $salesData');

      });
      // salesMap.forEach((key, value) {
      //   print('Value from For Each loop --- $value');
      //   String timestamp = value['timestamp'];
      //   DateTime saleDate = DateTime.parse(timestamp);
        
      //   // Check if saleDate is between startDate and endDate
      //   if (saleDate.isAfter(startDate) && saleDate.isBefore(endDate)) {
      //     if(value['shopId'] == widget.shopId){
      //       print("Shop Matched");
      //     salesData.add({
      //       'title': value['title'],
      //       'price': value['price'],
      //       'quantity': value['quantity'],
      //       'profit': value['profit'],
      //       'timestamp': value['timestamp'],
      //     });
      //     }
      //   }
      // });
    // print("Sales Data ==> $salesData");
      // Generate and open Excel sheet
    await createAndOpenExcel(salesData);
      print("File Has Been created........");
    } else {
      print('No sales data available');
    }
    // print('Snapshot ---> ${snapshot.snapshot.value}');
     });
  } catch (e) {
    print('Error fetching or processing sales data: $e');
  }
}

Future<void> createAndOpenExcel(
  List<Map<String, dynamic>> salesData
  ) async {
    final wb.Workbook workbook = wb.Workbook();
    final wb.Worksheet sheet= workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Title');
    sheet.getRangeByName('B1').setText('Price');
    sheet.getRangeByName('C1').setText('Quantity');
    sheet.getRangeByName('D1').setText("Profit");
    sheet.getRangeByName('E1').setText('Timestamp');

    for (int i = 0; i < salesData.length; i++) {
      final rowData = salesData[i];
      sheet.getRangeByName('A${i + 2}').setText(rowData['title'].toString());
      sheet.getRangeByName('B${i + 2}').setText(rowData['price'].toString());
      sheet.getRangeByName('C${i + 2}').setText(rowData['quantity'].toString());
      sheet.getRangeByName('D${i + 2}').setText(rowData['profit'].toString());
      sheet.getRangeByName('E${i + 2}').setText(rowData['Date'].toString());
    }

    // sheet.getRangeByName('A1').setText('Hello World!');
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

  final String path = (await getApplicationSupportDirectory()).path;
      final String fileName ='$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
      print(salesData);
  // try {
  //   final wb.Workbook workbook = wb.Workbook();
  //   final wb.Worksheet sheet= workbook.worksheets[0];
  //   sheet.getRangeByName("A!").setText("text");
  //   // Set headers
    
  //   // // sheet.cell(CellIndex.indexByString('B1')).value = 'Price';
  //   // // sheet.cell(CellIndex.indexByString('C1')).value = 'Quantity';
  //   // // sheet.cell(CellIndex.indexByString('D1')).value = 'Profit';
  //   // // sheet.cell(CellIndex.indexByString('E1')).value = 'Timestamp';

  //   // // Fill data into the Excel sheet

  //   // Save workbook as byte stream
  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();

  //   // Get the application directory path
  //   final String path = (await getApplicationDocumentsDirectory()).path;
  //   final String fileName = '$path/SalesData.xlsx';

  //   // Write bytes to file
  //   final File file = File(fileName);
  //   await file.writeAsBytes(bytes);
  //   print('Excel file saved at: $fileName');

  //   // Open the file
  // OpenFile.open(fileName);
  // } catch (e) {
  //   print('Error creating or opening file: $e');
  // }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor:const Color.fromRGBO(27,9,61,1.000),
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
            Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/sales.png'),
              ),
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
                                  style: const TextStyle(
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
        ElevatedButton(onPressed:
        // createAndOpenExcel
        ()async{
       await generateExcelSheet(_selectedStartDate!, _selectedEndDate!);

        }
        ,
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
        if(number > 9){
          return number.toString();
        }
  return number.toString().padLeft(2, '0');
}

}