import './main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenfree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosefree = false;

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, dynamic updateValue) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(title: const Text("Your Filters")),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            child: Text(
              "Adjust your meal Selection!",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTile("Lactose-free",
                  "Only include lactose-free meals", _lactosefree, (newValue) {
                setState(() {
                  _lactosefree = newValue;
                });
              }),
              _buildSwitchListTile(
                  "Vegetarian", "Only include Vegetarian meals", _vegetarian,
                  (newValue) {
                setState(() {
                  _vegetarian = newValue;
                });
              }),
              _buildSwitchListTile("Vegan", "Only include Vegan meals", _vegan,
                  (newValue) {
                setState(() {
                  _vegan = newValue;
                });
              }),
              _buildSwitchListTile(
                  "Gluten-free", "Only include gluten-free meals", _glutenfree,
                  (newValue) {
                setState(() {
                  _glutenfree = newValue;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
