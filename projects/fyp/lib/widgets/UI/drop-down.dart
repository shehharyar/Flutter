import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
 const DropDown({super.key, required this.value, this.onChanged, required this.items, required this.label});
  final dynamic value;
  final void Function(dynamic)? onChanged; 
    final List<dynamic> items;
    final String label;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  
  Widget build(BuildContext context) {
  print(widget.value);
  print(widget.items);
    return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: DropdownButtonFormField(
                            dropdownColor: const Color.fromARGB(255, 236, 220, 162),
                            value: widget.value,
                            items: [
                              for( var item in widget.items)
                                DropdownMenuItem(
                                  value: item,
                                  child: Text(item.toString()))
                            ],
                            decoration: InputDecoration(hintText: widget.label,
                       prefixIcon: const Icon(Icons.category_outlined, size: 18),
                       contentPadding: const EdgeInsets.all(12),
                      //  floatingLabelBehavior: FloatingLabelBehavior.never,
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
                            
                            onChanged:(value){
                              setState(() {
                             widget.onChanged?.call(value);
                                
                              });
                            }
                              // _enteredPassword= value!;
                           
                          ),
                        );
  }


}