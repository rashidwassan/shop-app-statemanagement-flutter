import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

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
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text("Shop"),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Orders"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, OrdersScreen.id),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Manage Products"),
            onTap: () =>
                Navigator.pushReplacementNamed(context, UserProductsScreen.id),
          ),
        ],
      ),
    );
  }
}
