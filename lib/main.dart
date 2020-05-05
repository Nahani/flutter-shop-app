import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/screens/catalog.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

void main() {
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Load products from json assets
    return FutureBuilder(
        future:
            DefaultAssetBundle.of(context).loadString('assets/products.json'),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Product> products = parseJson(snapshot.data.toString());
          return MultiProvider(
            providers: [
              Provider(create: (context) => CatalogModel(catalog: products)),
              // CartModel is implemented as a ChangeNotifier, which calls for the use
              // of ChangeNotifierProvider.
              ChangeNotifierProxyProvider<CatalogModel, CartModel>(
                create: (context) => CartModel(),
                update: (context, catalog, cart) {
                  return cart;
                },
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Constants.APP_TITLE,
              theme: new ThemeData(
                primaryColor: const Color(0xFF02BB9F),
                primaryColorDark: const Color(0xFF167F67),
                accentColor: const Color(0xFF167F67),
              ),
              initialRoute: '/catalog',
              routes: {
                '/catalog': (context) => Catalog(),
                '/cart': (context) => Cart(),
              },
            ),
          );
        });
  }

  // Parse a json content to a list of Product
  List<Product> parseJson(String response) {
    final parsed = json.decode(response.toString());
    if (parsed == null) {
      return [];
    }
    return parsed.map<Product>((json) => new Product.fromJson(json)).toList();
  }
}
