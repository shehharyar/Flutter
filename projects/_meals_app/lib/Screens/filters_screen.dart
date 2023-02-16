import './main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = "/filters";
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      drawer: const MainDrawer(),
      body: const Center(
        child: Text("Filters Screen"),
      ),
    );
  }
}
