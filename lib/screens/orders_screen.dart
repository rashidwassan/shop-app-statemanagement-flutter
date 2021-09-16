import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _orderData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: _orderData.orders.length,
          itemBuilder: (context, index) {
            return OrderItem(
              order: _orderData.orders[index],
            );
          }),
    );
  }
}
