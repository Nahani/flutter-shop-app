import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/models/cart.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

/* ************************************************* */
/* This widget display a card product in the catalog */
/* ************************************************* */
class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    bool isInCart = cart.contains(product.id);
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Card(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        // Read the name field value and set it in the Text widget
                        product.name,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      Text(
                        " (${product.unit.toString()}${Constants.UNIT})",
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
                    style: TextStyle(fontSize: 25.0, color: Colors.blue),
                  ),
                ],
              ),
              IconButton(
                  key: Key('${key.toString()}-ADD'),
                  icon: isInCart
                      ? Icon(Icons.check, semanticLabel: 'ADDED')
                      : Icon(Icons.add_shopping_cart),
                  tooltip: isInCart ? Constants.IS_IN_CART : Constants.ADD_CART,
                  // disabledColor: Colors.green,
                  onPressed: isInCart
                      ? () {}
                      : () {
                          cart.add(product);
                        })
            ],
          )),
          padding: const EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}
