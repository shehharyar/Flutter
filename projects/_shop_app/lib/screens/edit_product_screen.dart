// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'dart:convert';
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
  var _editedProduct= Product(id: null, title: '', description: '', price: 0, imageUrl: '');
 var _initValues= {
  'title': '',
  'description': '',
  'price': '',
  'imageUrl':''
 };
  var _isInit= true;
  var _isLoading= false;
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
    _isLoading= false;
    super.initState();
  }

@override
  void didChangeDependencies() {
    if(_isInit){
      // final productId= ModalRoute.of(context)!.settings.arguments as String;
      final productId= ModalRoute.of(context)!.settings.arguments;

      
      
  if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId.toString());
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
      //   _editedProduct= Provider.of<Products>(context,listen: false).findById(productId);
      // _initValues={
      //   'title': _editedProduct.title,
      //   'description': _editedProduct.description,
      //   'price': _editedProduct.price.toString(),
      //   'imageUrl': ''
      // };
      // _imageUrlController.text= _editedProduct.imageUrl;
    }
    _isInit= false;
    super.didChangeDependencies();
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
  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  setState(() {
    _isLoading=true;
  });

  print(_editedProduct.id);
if(_editedProduct.id != null){
  await Provider.of<Products>(context, listen:false).updateProduct(_editedProduct.id, _editedProduct);
}
else{
try{

 await Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
}
catch(error){
   showDialog(context: context, 
        builder: (ctx)=>
        AlertDialog(
          title: const Text("An Error Occured!"),
          content: const Text("Something Went Wrong!"),
          actions: [
            TextButton(
              onPressed: (){
              Navigator.of(ctx).pop();
            }, child:const Text('Okay'))
          ],
        ));
}

}
setState(() {
    _isLoading= false;
    Navigator.of(context).pop();
  });
   

  
    // print();
  //   if(_editedProduct.id ){
  //     Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
  //     Navigator.of(context).pop();
  //   }
  //   else{
  //     try{
  //  await Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
  //           Navigator.of(context).pop();
  
  //     }
  //     catch(error){
  //       showDialog(context: context, 
  //       builder: (ctx)=>
  //       AlertDialog(
  //         title: const Text("An Error Occured!"),
  //         content: const Text("Something Went Wrong!"),
  //         actions: [
  //           TextButton(
  //             onPressed: (){
  //             Navigator.of(ctx).pop();
  //           }, child:const Text('Okay'))
  //         ],
  //       ));
  //     }finally{
  //       setState(() {
  //         _isLoading=false;
  //         Navigator.of(context).pop();
  //       });
  //     }
  //     } 
        
    }
    
     
  // void _saveForm(){
  //   final isValid= _form.currentState!.validate();
  //     if(!isValid){
  //       return;
  //     }
  //   _form.currentState!.save();
  //     setState(() {
  //       _isLoading= true;  
  //     });
  // print(_editedProduct);
  // if(_editedProduct.id != null){

  //   Provider.of<Products>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct) ;
  //   setState(() {
  //     _isLoading= false;
  //   });
  //   Navigator.of(context).pop();
  // }
  // else{
  //   Provider.of<Products>(context, listen: false).addProduct(_editedProduct).then((_) {
  //   print("Added Products called");
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   Navigator.of(context).pop();
      
  //   },);

  // }

  // }

  @override
  Widget build(BuildContext context) {
    print(_editedProduct.id);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions:[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ]
        ),
      body: _isLoading 
      ? 
     const Center(child: Text("Loadung..."),) 
      : 
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
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
                  _editedProduct=  Product(id: _editedProduct.id, title: value.toString(), 
                  description: _editedProduct.description, price: _editedProduct.price, 
                  imageUrl: _editedProduct.imageUrl,
                  isFavourite: _editedProduct.isFavourite
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
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
                  _editedProduct=  Product(id: _editedProduct.id, title: _editedProduct.title, 
                  description: _editedProduct.description, price: double.parse(value!), imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite
                  
                  );
                },
                ),
            
              TextFormField(
                initialValue: _initValues['description'],
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
                  _editedProduct=  Product(id: _editedProduct.id, title: _editedProduct.title, 
                      description: value.toString(), price: _editedProduct.price, 
                      imageUrl: _editedProduct.imageUrl,
                      isFavourite: _editedProduct.isFavourite
                      );
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
                    // initialValue: _initValues['imageUrl'],
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
                                      id: _editedProduct.id, 
                                      title: _editedProduct.title, 
                                      description: _editedProduct.description, 
                                      price: _editedProduct.price, 
                                      imageUrl: value!,
                                      isFavourite: _editedProduct.isFavourite
                                      
                                       );
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
