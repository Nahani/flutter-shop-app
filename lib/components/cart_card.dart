import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

/* ************************************************ */
/* This widget display a card product in the cart  */
/* ************************************************ */
class CartProductCard extends StatelessWidget {
  final Product productCart;
  CartProductCard({Key key, this.productCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<CatalogModel>(context);
    var cart = Provider.of<CartModel>(context);
    Product product = catalog.getById(productCart.id);
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: new Card(
        child: Container(
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: NetworkImage(product.picture),
                  width: 100,
                ),
              ),
              Column(
                // Stretch the cards in horizontal axis
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        // Read the name field value and set it in the Text widget
                        product.name,
                        // set some style to text
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      Text(
                        // Read the name field value and set it in the Text widget
                        " (${product.unit.toString()}${Constants.UNIT})",
                        // set some style to text
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  Text(
                    // Read the name field value and set it in the Text widget
                    product.price.toString() + Constants.PRICE_UNIT,
                    // set some style to text
                    style: TextStyle(fontSize: 25.0, color: Colors.blue),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                          key: Key("${key.toString()}-ADD-QT"),
                          icon: Icon(Icons.add_circle),
                          tooltip: Constants.TOOLTIP_ADD,
                          onPressed: () {
                            cart.addQuantity(productCart.id);
                          }),
                      Text(productCart.quantity.toString()),
                      IconButton(
                          key: Key("${key.toString()}-REMOVE-QT"),
                          icon: Icon(Icons.remove_circle),
                          tooltip: Constants.TOOLTIP_REMOVE,
                          onPressed: productCart.quantity > 1
                              ? () {
                                  cart.removeQuantity(productCart.id);
                                }
                              : null),
                    ],
                  ),
                  IconButton(
                      key: Key("${key.toString()}-REMOVE"),
                      icon: Icon(Icons.remove_shopping_cart),
                      tooltip: Constants.REMOVE_CART,
                      onPressed: () {
                        cart.remove(productCart.id);
                      })
                ],
              ),
            ],
          )),
          padding: const EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}
