import 'package:flutter/material.dart';
import 'package:shopapp/components/products_list.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:badges/badges.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

/* ******************************************************** */
/*       This widget display the catalog screen             */
/* ******************************************************** */
class Catalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the catalog provider to get the list of products
    var catalog = Provider.of<CatalogModel>(context);
    return Consumer<CartModel>(builder: (context, cart, child) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(
              Constants.CATALOG_TITLE,
              style: new TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 30.0),
                child: Badge(
                  key: Key(Constants.KEY_BADGE),
                  badgeContent: Text(
                    '${cart.numberProduct}',
                    style: new TextStyle(color: Colors.white),
                  ),
                  animationType: BadgeAnimationType.scale,
                  position: BadgePosition.topRight(top: 0, right: 0),
                  child: IconButton(
                    key: Key(Constants.KEY_CART_BUTTON),
                    icon: const Icon(Icons.shopping_cart),
                    tooltip: Constants.TOOLTIP_CART,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Cart()),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
          body: ProductList(products: catalog.products));
    });
  }
}
