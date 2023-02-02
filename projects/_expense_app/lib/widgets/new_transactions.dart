import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx, {super.key});

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
              ),
              TextField(
                // onChanged: (val) => amountInput = val,
                decoration: const InputDecoration(labelText: "Amount"),
                controller: amountController,
              ),
              TextButton(
                onPressed: () {
                  addTx(titleController.text, double.parse(amountController.text));
                  // print(titleController.text);
                  // print(amountController.text);
                },
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
