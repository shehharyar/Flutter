import 'package:flutter/material.dart';
import '../providers/Product.dart';
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});
  static const routeName = "/edit-product";
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode= FocusNode();
  final _imageUrlController = TextEditingController();
  final _form= GlobalKey<FormState>();
  var _editedProduct= Product(id: DateTime.now().toString(), title: "", description: "", price: 0, imageUrl: "");
  // final _imgUrlFocusNode = FocusNode();
  // final _priceFocusNode = FocusNode();
  @override
  void initState(){
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
 void dispose(){
  _imageUrlFocusNode.removeListener(_updateImageUrl);
  _priceFocusNode.dispose();
  _descriptionFocusNode.dispose();
  _imageUrlController.dispose();
  super.dispose();
 }

  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      setState(() {
        
      });
    }
  }

  void _saveForm(){
    _form.currentState!.save();
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
          key: _form,
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Title"),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value){
                _editedProduct= Product(id:_editedProduct.id, title: value.toString(), description: _editedProduct.description, price: _editedProduct.price, imageUrl: _editedProduct.imageUrl);
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
              onSaved: (value){
                _editedProduct= Product(id:_editedProduct.id, title: _editedProduct.title, description: _editedProduct.description, price: double.parse(value!), imageUrl: _editedProduct.imageUrl);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Description"),
              textInputAction: TextInputAction.next,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_){
                FocusScope.of(context).requestFocus(_imageUrlFocusNode);
              },
              onSaved: (value){
                _editedProduct= Product(id:_editedProduct.id, title: _editedProduct.title, description: value.toString(), price: _editedProduct.price, imageUrl: _editedProduct.imageUrl);
              },
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height:100,
                  margin: const EdgeInsets.only(
                    top: 8,
                    right:10
                 ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey
                  )
                ),
                child: Container(
                  child: _imageUrlController.text.isEmpty ? 
                  const Text("Enter An Url")
                  : 
                  FittedBox(child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                    
                    )
                    ,)
                ),
                ),
                Expanded
                (
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Image Url"),
                    keyboardType:TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (value){
                    _editedProduct= Product(id:_editedProduct.id, title: _editedProduct.title, description: _editedProduct.description, price: _editedProduct.price, imageUrl: value.toString());
                     },
                    onFieldSubmitted: (_){
                      _saveForm();
                    },
                                    ),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
