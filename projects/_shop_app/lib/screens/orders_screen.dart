import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/oder_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your orders"),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItems(orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
