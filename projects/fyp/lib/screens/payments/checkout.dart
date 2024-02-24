import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fyp/data/methods.dart';
import 'package:fyp/model/cart.dart';
import 'package:fyp/widgets/UI/TextInput.dart';
import 'package:fyp/widgets/UI/drop-down.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';



FirebaseDatabase database = FirebaseDatabase.instance;

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({super.key, required this.orders, required this.shopId});
  final List<CartItem> orders;
  final String shopId;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _form = GlobalKey<FormState>();
  var _selectedBusiness = methods.first;
  var _enteredCustomerName = '';
  var _enteredCustomerPhoneNum = '';
  var  _enteredCreditCard = '';
  var _enteredCVV='';
   var uuid = const Uuid();
Future<void> _addToSales(List<CartItem> cartItems) async {
  final _isValid= _form.currentState!.validate();

  if(!_isValid){
    return showDialog(context: context, builder: (ctx) => AlertDialog( title: const Text("Invalid Inputs!"),
          content: const Text("Please Enter All Fields!"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },)]));
  }
  _form.currentState!.save(); // Save the form fields

  try {
    final salesId = uuid.v4();
    final currentDate = DateTime.now().toString().split(' ')[0]; // Get today's date
    Map<String, dynamic> saleData = {
      'timestamp': currentDate,
      'items': cartItems.map((cart) => {
        'title': cart.title,
        'price': cart.price,
        'quantity': cart.quantity,
        'profit': (cart.price / 4) * cart.quantity!, // Assuming profit calculation
        'id': salesId,
        'shopId': widget.shopId
      }).toList(),
    };

    // Get existing sales data
    final existingSalesSnapshot = await database.ref().child('sales').once();
    Map<dynamic, dynamic>? existingSalesData = existingSalesSnapshot.snapshot.value as Map?;

    if (existingSalesData == null) {
      existingSalesData = {};
    }

    // Update or add items to the sales data
    saleData['items'].forEach((item) {
      bool itemExists = false;

      existingSalesData?.forEach((key, value) {
        if(value['timestamp'] == currentDate){
        List<dynamic> items = value['items'];
        
        for (var existingItem in items) {

          if (existingItem['title'] == item['title']) {
            // Update existing item
            existingItem['quantity'] += item['quantity'];
            existingItem['price'] += item['price'];
            existingItem['profit'] += item['profit'];
            itemExists = true;
            break;
          }
        }
     } });

      // If item doesn't exist, add it to the existing sales data
      if (!itemExists) {
        if (existingSalesData?[salesId] != null) {
          existingSalesData?[salesId]['items'].add(item);
        } else {
          existingSalesData?[salesId] = {
            'timestamp': currentDate,
            'items': [item]
          };
        }
      }
    });

    // Update the sales data in the database
    await database.ref().child('sales').set(existingSalesData);
print("Enter Name: $_enteredCustomerName ");
    // Clear the cart if successful
    
    
     _createPDF(cartItems, _enteredCustomerName, _enteredCustomerPhoneNum);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sale data added successfully')),
    );
  } on FirebaseException catch (e) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.message ?? "Can't send data...")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    print('business=== $_selectedBusiness');
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(27, 9, 61, 1.000),
              Color.fromRGBO(82, 36, 91, 1.000),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset('assets/images/checkout.png'),
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextInput(
                            validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Required!.";
                              }
                            },
                            icon: Icons.account_circle_outlined,
                            onSaved: (value) {
                              _enteredCustomerName = value!;
                            },
                            label: "Customer Name",
                          ),
                          const SizedBox(height: 12),
                          TextInput(
                             validator: (value){
                              if(value!.isEmpty){
                                return "This Field is Required!.";
                              }
                            },
                            keyboardType: TextInputType.phone,
                            icon: Icons.phone,
                            onSaved: (value) {
                              _enteredCustomerPhoneNum = value!;
                            },
                            label: "Phone Number",
                          ),
                          const SizedBox(height: 12),
                     if(_selectedBusiness == "Credit Card")
                          TextInput(
                            
                            icon: Icons.credit_card_rounded,
                            onSaved: (value) {
                              _enteredCreditCard = value!;
                            },
                            label: "Card Name",
                          ),
                          const SizedBox(height: 12),
                     if(_selectedBusiness == "Credit Card")
                          TextInput(
                            icon: Icons.lock_outlined,
                            onSaved: (value) {
                              _enteredCVV = value!;
                            },
                            label: "CVV",
                          ),
                          const SizedBox(height: 12),
                     if(_selectedBusiness == "Credit Card")
                          TextInput(
                            icon: Icons.calendar_month_outlined,
                            onSaved: (value) {
                              _enteredCreditCard = value!;
                            },
                            label: "Expiration Date",
                          ),
                          // const SizedBox(height: 12),
                          DropDown(
                            value: _selectedBusiness,
                            onChanged: (value) {
                              setState(() {
                                _selectedBusiness = value!;
                              });
                            },
                            items: methods,
                            label: "Select Payment Type",
                          ),
                          ElevatedButton.icon(
                            onPressed: (){
                              _addToSales(widget.orders);
                            },
                            icon: const Icon(Icons.check_circle_outlined),
                            label: const Text("Checkout"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Skip'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _createPDF(List<CartItem> carts, String _customerName, String _customerPhone) async {
    final pdf = pw.Document();
    final file = File('${(await getTemporaryDirectory()).path}/carts.pdf');
    if(carts.isEmpty){
      return;
    }
double totalAmount = 0;
  for (var cart in carts) {
    totalAmount += (cart.price * cart.quantity!);
  }

  print("Enter Name : $_customerName");
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          // print(carts);
          return <pw.Widget>[
           pw.Center(
            child: pw.Text(
              'Easy Food',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Column(children:[
          pw.Text("Customer Name : $_customerName"),
          pw.Text("Customer Phone # $_customerPhone"),
          ]
             )
,            
            
            // ignore: deprecated_member_use
            pw.Table.fromTextArray(
              border: pw.TableBorder.all(),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            headerHeight: 25,
            cellHeight: 25,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.center,
              2: pw.Alignment.center,
            },
              data: <List<String>>[
            
                <String>['Item', 'Price', 'Quantity'],
                ...carts.map((cart) => [cart.title, cart.price.toString(), cart.quantity.toString()]),
              ],
            ),
            pw.SizedBox(height: 19),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children:[
               pw.Text(
              'Total: ${
                  totalAmount.toStringAsFixed(2)
                // carts.map((cart) =>(cart.price  * double.parse(cart.quantity as String)) )
              }',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
            ), 
              ] )
          ];
        },
      ),
    );

    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
   
   carts.clear();
  }
}
