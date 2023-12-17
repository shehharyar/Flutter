// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
 TextInput({super.key, required this.onSaved, this.validator, required this.label, this.icon, this.keyboardType});
  final void Function(String?)? onSaved;  
  String? Function(String?)? validator;
  final String label;
  IconData? icon;
  TextInputType? keyboardType;
@override
  Widget build(BuildContext context) {
    return  TextFormField(
                      onSaved: onSaved,         
                       validator: validator,
                      keyboardType: keyboardType ,
                      decoration: InputDecoration(hintText: label,
                      
                       prefixIcon:  Icon(icon, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                       floatingLabelBehavior: FloatingLabelBehavior.never,
                       hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.deepPurple[700]),
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(10)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: Colors.transparent),
                                            borderRadius: BorderRadius.circular(10)),
                                        filled: true,
                                        fillColor: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                                      ),
              
                    );
  }
}