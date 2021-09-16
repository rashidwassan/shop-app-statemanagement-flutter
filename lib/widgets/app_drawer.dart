import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Hello Friend!'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrdersScreen.id),
          ),
        ],
      ),
    );
  }
}
