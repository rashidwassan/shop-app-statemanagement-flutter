import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    this.showFavs = false,
    Key? key,
  }) : super(key: key);

  final bool showFavs;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        showFavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemBuilder: (context, index) {
          /*
            Here the value constructor of provider is used since we don't need
            context which is provided by builder by provider.
            This constructor is also useful for listViews and gridViews.
           */
          return ChangeNotifierProvider.value(
            value: loadedProducts[index],
            // create: (context) => loadedProducts[index],
            child: const ProductItem(),
          );
        });
  }
}
