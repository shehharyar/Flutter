import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit-product";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  // final _imgUrlFocusNode = FocusNode();
  // final _priceFocusNode = FocusNode();
  @override
 void dispose(){
  _priceFocusNode.dispose();
  _descriptionFocusNode.dispose();
  super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Price"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode
            ),

            Row(
              children: [
                Container(
                  width: 100,
                  height:100,
                  margin: EdgeInsets.only(
                    top: 8,
                    right:10
                 ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey
                  )
                ),
                child: Container(),
                ),
                TextFormField()
              ],
            )
          ],
        )),
      ),
    );
  }
}
