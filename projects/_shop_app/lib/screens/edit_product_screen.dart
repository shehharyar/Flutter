import 'package:_shop_app/providers/Product.dart';
import 'package:_shop_app/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen ({super.key});
  static const routeName= '/edit-products';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode= FocusNode();
  final _descriptionFocusNode= FocusNode();
  final _imageUrlController= TextEditingController();  
  final _imageUrlFocusNode= FocusNode();
  final _form= GlobalKey<FormState>();
  var _editedProduct= Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
  @override
  void initState() {
   _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl(){
     if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {
        //
      });
    }
  }

  void _saveForm(){
    final isValid= _form.currentState!.validate();
      if(!isValid){
        return;
      }

    _form.currentState!.save();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions:[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ]
        ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocusNode),
                 validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  if(value.trim().length < 3){
                    return "Should be at least 3 characters long";
                  }
                  return null;
                },

                onSaved: (value) {
                  _editedProduct=  Product(id: '', title: value.toString(), 
                  description: _editedProduct.description, price: _editedProduct.price, imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter a Price";
                  }
                  if(double.tryParse(value) == null){
                    return "please enter a valid number";
                  }
                  if(double.parse(value) <= 0 ){
                    return "Please enter a number greater than zero.";
                  }
                  return null;
                },
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocusNode), 
                onSaved: (value) {
                  _editedProduct=  Product(id: '', title: _editedProduct.title, 
                  description: _editedProduct.description, price: double.parse(value!), imageUrl: _editedProduct.imageUrl);
                },
                ),
            
              TextFormField(
                decoration: const InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                keyboardAppearance: Brightness.dark,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter a description.";
                  }
                  if(value.trim().length < 10){
                    return "Shiuld be at least 10 characters long.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct=  Product(id: '', title: _editedProduct.title, 
                      description: value.toString(), price: _editedProduct.price, imageUrl: _editedProduct.imageUrl);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.grey
                    )
                  ),
                  child: Container(
                        alignment: _imageUrlController.text.isEmpty ? Alignment.center : null,
                        child:  
                        _imageUrlController.text.isEmpty ?
                         const Text("Enter a Url",
                         textAlign: TextAlign.center,

                         ) 
                         :  
                         FittedBox( child: Image.network(_imageUrlController.text),
                        fit: BoxFit.cover, )
                  ),
                ),

                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(label: Text('Image URL')),
                    keyboardType:TextInputType.url,
                    textInputAction: TextInputAction.done,
                    controller:_imageUrlController ,
                    focusNode: _imageUrlFocusNode,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter a Url";
                      }
                      if(!value.startsWith('http') && !value.startsWith('https')){
                        return "Enter a Valid Url";
                      }
                      if(!value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')){
                        return "Please Enter a valid Image Url.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                  _editedProduct=  Product(
                                      id: '', 
                                      title: _editedProduct.title, 
                                      description: _editedProduct.description, 
                                      price: _editedProduct.price, 
                                      imageUrl: value! );
                },
                    onFieldSubmitted: (_) => _saveForm ,
                  ),
                )
              ],)
               
            ],
          ) 
        ), 
        ),
      );
  }
}
