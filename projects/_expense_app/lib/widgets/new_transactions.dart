import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx, {super.key});

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTx(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                // onChanged: (val) => titleInput = val,
                decoration: const InputDecoration(labelText: "title"),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                // onChanged: (val) => amountInput = val,
                decoration: const InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              TextButton(
                onPressed: submitData,
                child: const Text(
                  "Add transaction",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          )),
    );
  }
}
