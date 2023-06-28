import 'dart:convert';
import './Product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
class Products with ChangeNotifier {
   List<Product> _items = [
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavourite).toList();
  }

  Product findById(id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
  Future<void> fetchAndSetProduct() async {
    final url= Uri.https("flutter-backend-6a7d0-default-rtdb.firebaseio.com", "products.json");
   try{
      final response= await http.get(url);
      final extractedData= json.decode(response.body) as Map<String, dynamic>;
      final List<Product> _loadedProducts =[];
      extractedData.forEach((prodId, product) {
        _loadedProducts.add(
          Product(id: prodId, title: product['title'], description: product['description'],
           price: product['price'], imageUrl: product['imageUrl'],
           isFavourite: product['isFavourite'])
        );
      },);

    _items= _loadedProducts;
    notifyListeners();

   }
   catch(error){
      throw(error); 
   }


  }

  Future<void> addProduct(Product product ) async {
  
    final url= Uri.https("flutter-backend-6a7d0-default-rtdb.firebaseio.com", "products.json");
    try{
      final response= await http.post(
    url,   
    headers: {
          'Content-Type': 'application/json',
        },
    body: json.encode({
        'title': product.title, 
        'description': product.description, 
        'price': product.price, 
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite
      } , ),
  );
  final newProduct= Product( 

    title: product.title, 
    description: product.description, 
    price: product.price, 
    imageUrl: product.imageUrl,
    isFavourite: product.isFavourite,
    id: json.decode(response.body)['name']
    );
    
    _items.add(newProduct);
    notifyListeners();
    }catch(error){
      print(error.toString());
      rethrow;
    }
  }
Future<void> updateProduct(String? id, Product newProduct) async{
    final prodIndex =  _items.toList().indexWhere((prod) => prod.id == id);
    print(_items.indexWhere((element) => element.id == id));
    print(prodIndex);
    if (prodIndex >= 0) {
    final url= Uri.https("flutter-backend-6a7d0-default-rtdb.firebaseio.com", "products/$id.json");
   await http.patch(url, body:json.encode({
      'title':newProduct.title,
      'description': newProduct.description,
      'price': newProduct.price,
      'imageUrl': newProduct.imageUrl
    }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('updated');
      print('...');
    }
}

  void deleteProduct(String id) {
    final url= Uri.https("flutter-backend-6a7d0-default-rtdb.firebaseio.com", "products/$id.json");
   final existingProductIndex= _items.indexWhere((prod) => prod.id == id);
   Product? existingProduct= _items[existingProductIndex];
   http.delete(url).then((_){
    existingProduct=null;
   }).catchError((_){
    _items.insert(existingProductIndex, existingProduct!);
    notifyListeners();
   });
    _items.removeAt(existingProductIndex);
    notifyListeners();
  }

}