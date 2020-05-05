import 'package:flutter/material.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/components/cart_list.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

/* ******************************************************** */
/*       This widget display the Cart screen             */
/* ******************************************************** */
class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cart, child) {
      return new Scaffold(
          appBar: new AppBar(
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: new Text(
              Constants.CART_TITLE,
              style: new TextStyle(color: Colors.white),
            ),
          ),
          body: Align(
              alignment: Alignment.center,
              child: cart.products.length == 0
                  ? Text(Constants.CART_EMPTY, style: TextStyle(fontSize: 20))
                  : SingleChildScrollView(
                      child: Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Column(
                        children: <Widget>[
                          CartList(products: cart.products),
                          const SizedBox(height: 15),
                          Text(
                            '${Constants.TOTAL_PRICE} ${cart.totalPrice.toString()}\$',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 30),
                          RaisedButton(
                            hoverColor: Colors.green,
                            color: Colors.lightBlue,
                            onPressed: () {},
                            child: const Text(Constants.BUY_BUTTON,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          ),
                        ],
                      ),
                    ))));
    });
  }
}
