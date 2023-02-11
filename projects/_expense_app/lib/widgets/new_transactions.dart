// ignore_for_file: avoid_init_to_null

import "dart:io";

import 'package:_expense_app/widgets/adaptive_text_Button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime? _selectedDate = null;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }

        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                left: 10,
                right: 10,
                top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  // onChanged: (val) => titleInput = val,
                  decoration: const InputDecoration(labelText: "title"),
                  controller: _titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                  // onChanged: (val) => amountInput = val,
                  decoration: const InputDecoration(labelText: "Amount"),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      // ignore: unnecessary_null_comparison
                      Expanded(
                        child: Text(_selectedDate == null
                            ? "No date chosen"
                            : DateFormat.yMMMd().format(_selectedDate!)),
                      ),
                      AdaptiveTextButton("Choose Date", _presentDatePicker)
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitData,
                  child: const Text("Add transaction"),
                ),
              ],
            )),
      ),
    );
  }
}
