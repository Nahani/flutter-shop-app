import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/components/cart_card.dart';

/* ******************************************************** */
/* This widget display the list of the products in the cart */
/* ******************************************************** */
class CartList extends StatelessWidget {
  final List<Product> products;
  CartList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: products == null ? 0 : products.length,
        itemBuilder: (BuildContext context, int index) {
          return new CartProductCard(
            productCart: products[index],
            key: Key(products[index].id.toString()),
          );
        });
  }
}
