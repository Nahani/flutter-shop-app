import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/components/product_card.dart';

/* *********************************************************** */
/* This widget display the list of the products in the catalog */
/* *********************************************************** */
class ProductList extends StatelessWidget {
  final List<Product> products;
  ProductList({Key key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: new ListView.builder(
            itemCount: products == null ? 0 : products.length,
            itemBuilder: (BuildContext context, int index) {
              return new ProductCard(
                  product: products[index],
                  key: Key(products[index].id.toString()));
            }),
      ),
    );
  }
}
