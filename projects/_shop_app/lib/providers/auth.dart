import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier{
//  late String _token;
// late DateTime _expiryDate;
// late String _userId;
//
  Future<void> signup(String email, String password) async{
    final url= Uri.https('identitytoolkit.googleapis.com', 'v1/accounts:signUp', {'key': 'AIzaSyAjXIKVvx46K1W6Yxp75G-AR6wKwSJsLH8'});
 final response = await http.post(url, body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      }));
  print(json.decode(response.body));

  
  }
}