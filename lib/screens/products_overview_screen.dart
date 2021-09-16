// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoritesOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'MyShop',
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          PopupMenuButton(
              //  color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onSelected: (v) {
                if (v == FilterOptions.Favorites) {
                  setState(() {
                    _showFavoritesOnly = true;
                  });
                } else {
                  setState(() {
                    _showFavoritesOnly = false;
                  });
                }
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text('Only Favourites'),
                    value: FilterOptions.Favorites,
                  ),
                  const PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ];
              }),
          Consumer<Cart>(
            builder: (context, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.id);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(
        showFavs: _showFavoritesOnly,
      ),
    );
  }
}
