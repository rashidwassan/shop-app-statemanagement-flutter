import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const id = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryVariant,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    textColor: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'ORDER NOW!',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    return CartItem(
                      cart.items.values.toList()[index].id,
                      cart.items.keys.toList()[index],
                      cart.items.values.toList()[index].price,
                      cart.items.values.toList()[index].quantity,
                      cart.items.values.toList()[index].title,
                    );
                  }))
        ],
      ),
    );
  }
}
