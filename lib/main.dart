import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import '../screens/products_overview_screen.dart';

void main() {
  runApp(const ShopApp());
}

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
            fontFamily: 'Lato',
            appBarTheme: const AppBarTheme(elevation: 2),
            colorScheme: ColorScheme(
                primary: Colors.purple,
                secondary: Colors.deepOrange,
                brightness: Brightness.light,
                background: Colors.white,
                primaryVariant: Colors.purpleAccent,
                error: Colors.red,
                onBackground: Colors.black87,
                onError: Colors.white,
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onSurface: Colors.black87,
                secondaryVariant: Colors.deepOrange.shade700,
                surface: Colors.white)),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.id: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
