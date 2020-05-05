import 'package:flutter_test/flutter_test.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/catalog.dart';

void main() {
  Product testProduct1 = Product(
      id: 1, name: "Test Product 1", price: 18, picture: "mypicture.jpg");
  Product testProduct2 = Product(
      id: 2, name: "Test Product 2", price: 10, picture: "mypicture2.jpg");
  Product testProduct3 = Product(
      id: 3, name: "Test Product 3", price: 6, picture: "mypicture3.jpg");
  test('Add products in the cart', () {
    final cart = CartModel();

    expect(cart.numberProduct, 0);

    cart.add(testProduct1);
    expect(cart.numberProduct, 1);

    cart.add(testProduct2);
    expect(cart.numberProduct, 2);

    cart.add(testProduct3);
    expect(cart.numberProduct, 3);
  });

  test('Add a product that already exist in the cart', () {
    final cart = CartModel();

    expect(cart.numberProduct, 0);

    cart.add(testProduct1);
    expect(cart.numberProduct, 1);

    cart.add(testProduct1);
    expect(cart.numberProduct, 1);
  });

  test('Remove products in the cart', () {
    final cart = CartModel();

    expect(cart.numberProduct, 0);
    cart.add(testProduct1);
    cart.add(testProduct2);
    expect(cart.numberProduct, 2);

    cart.remove(testProduct1.id);

    expect(cart.numberProduct, 1);
  });

  test('Add quantity of a product', () {
    final cart = CartModel();

    cart.add(testProduct1);
    cart.add(testProduct2);
    cart.add(testProduct3);

    expect(cart.products[1].quantity, 1);
    cart.addQuantity(testProduct2.id);
    cart.addQuantity(testProduct2.id);
    expect(cart.products[1].quantity, 3);
  });

  test('Remove quantity of a product', () {
    final cart = CartModel();

    Product p1 = Product(
        id: 1, name: "Test Product 1", price: 18, picture: "mypicture.jpg");
    Product p2 = Product(
        id: 2, name: "Test Product 2", price: 10, picture: "mypicture2.jpg");
    Product p3 = Product(
        id: 3, name: "Test Product 3", price: 6, picture: "mypicture3.jpg");

    cart.add(p1);
    cart.add(p2);
    cart.add(p3);

    expect(cart.products[1].quantity, 1);
    cart.addQuantity(p2.id);
    expect(cart.products[1].quantity, 2);
    cart.addQuantity(p2.id);
    expect(cart.products[1].quantity, 3);

    cart.removeQuantity(p2.id);
    expect(cart.products[1].quantity, 2);
    cart.removeQuantity(p2.id);
    expect(cart.products[1].quantity, 1);
  });

  test('Get the total price of the cart', () {
    final cart = CartModel();

    Product p1 = Product(
        id: 1, name: "Test Product 1", price: 18, picture: "mypicture.jpg");
    Product p2 = Product(
        id: 2, name: "Test Product 2", price: 10, picture: "mypicture2.jpg");
    Product p3 = Product(
        id: 3, name: "Test Product 3", price: 6, picture: "mypicture3.jpg");

    cart.add(p1);
    cart.add(p2);
    cart.add(p3);

    expect(cart.totalPrice, 34);

    expect(cart.products[1].quantity, 1);
    cart.addQuantity(p2.id);
    expect(cart.products[1].quantity, 2);
    cart.addQuantity(p2.id);
    expect(cart.products[1].quantity, 3);

    expect(cart.totalPrice, 54);

    cart.removeQuantity(p2.id);
    expect(cart.products[1].quantity, 2);
    cart.removeQuantity(p2.id);
    expect(cart.products[1].quantity, 1);

    expect(cart.totalPrice, 34);
  });

  test('Get if the product is in the cart or not', () {
    final cart = CartModel();

    expect(cart.contains(testProduct1.id), false);
    cart.add(testProduct1);
    expect(cart.contains(testProduct1.id), true);
    cart.remove(testProduct1.id);
    expect(cart.contains(testProduct1.id), false);
  });
}
