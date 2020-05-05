import 'package:flutter/foundation.dart';
import 'package:shopapp/models/catalog.dart';

/* ************************************************ */
/*   CartModel represent the cart that contains     */
/*   all the products to display in the cart        */
/* ************************************************ */
class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  /// List of products in the cart.
  List<Product> get products => _products;

  // Get the number of different products in the cart
  int get numberProduct => _products.length;

  // Check if a produt id is present in the cart
  bool contains(int id) {
    int index = _products.indexWhere((element) => element.id == id);
    if (index < 0) {
      return false;
    }
    return true;
  }

  /// Add a product to the cart
  void add(Product product) {
    // Check if the product is already in the cart
    int index = _products.indexWhere((element) => element.id == product.id);
    if (index < 0) {
      // If the product in not present in the cart we add this new product
      _products.add(product);
    } else {
      // If the product is already present in the cart we increment the quantity
      _products[index].quantity = _products[index].quantity + 1;
    }

    // Notify listeners to update consumers widget
    notifyListeners();
  }

  void addQuantity(int id) {
    // Check if the product is present in the cart
    int index = _products.indexWhere((element) => element.id == id);

    if (index >= 0) {
      _products[index].quantity = _products[index].quantity + 1;
    }
    // Notify listeners to update consumers widget
    notifyListeners();
  }

  void removeQuantity(int id) {
    // Check if the product is present in the cart
    int index = _products.indexWhere((element) => element.id == id);

    if (index >= 0 && _products[index].quantity > 1) {
      _products[index].quantity = _products[index].quantity - 1;
    }

    // Notify listeners to update consumers widget
    notifyListeners();
  }

  void remove(int id) {
    // Remove the product
    _products.removeWhere((element) => element.id == id);
    // Notify listeners to update consumers widget
    notifyListeners();
  }

  // Get the total price of the cart
  int get totalPrice => _products.fold(
      0, (total, current) => total + current.price * current.quantity);
}
