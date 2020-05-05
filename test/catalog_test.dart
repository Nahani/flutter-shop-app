import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/catalog.dart';
import 'package:shopapp/screens/cart.dart';
import 'package:shopapp/screens/catalog.dart';
import 'package:provider/provider.dart';
import 'package:image_test_utils/image_test_utils.dart';
import 'package:shopapp/ressources/constants.dart' as Constants;

void main() {
  Product testProduct1 = Product(
      id: 2565, name: "Test Product 1", price: 18, picture: "mypicture.jpg");
  Product testProduct2 = Product(
      id: 4567, name: "Test Product 2", price: 10, picture: "mypicture2.jpg");
  Product testProduct3 = Product(
      id: 9876, name: "Test Product 3", price: 6, picture: "mypicture3.jpg");

  List<Product> products = [testProduct1, testProduct2, testProduct3];

  testWidgets('Test the catalog page', (WidgetTester tester) async {
    provideMockedNetworkImages(() async {
      // Pump the catalog model with the mock Provider
      await tester.pumpWidget(MultiProvider(
        providers: [
          Provider(create: (context) => CatalogModel(catalog: products)),
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
      ));

      // Check the title
      expect(find.text(Constants.CATALOG_TITLE), findsOneWidget);

      // Check if we found all the products
      final testKey1 = Key(testProduct1.id.toString());
      final testKey2 = Key(testProduct2.id.toString());
      final testKey3 = Key(testProduct3.id.toString());

      // Expect to find all the keys of the producst catalog
      expect(find.byKey(testKey1), findsOneWidget);
      expect(find.byKey(testKey2), findsOneWidget);
      expect(find.byKey(testKey3), findsOneWidget);

      // Check the cart badge value to be 0
      expect(find.text("0"), findsOneWidget);
      expect(find.text("1"), findsNothing);

      //Add a product int the cart
      // Tap the add button.
      expect(find.byKey(Key("${testKey1.toString()}-ADD")), findsOneWidget);
      await tester.tap(find.byKey(Key("${testKey1.toString()}-ADD")));

      // Rebuild the widget after the state has changed.
      await tester.pump();

      // Expect the cart badge value to be 1.
      expect(find.text("1"), findsOneWidget);

      //Add a another product int the cart
      // Tap the add button.
      expect(find.byKey(Key("${testKey3.toString()}-ADD")), findsOneWidget);
      await tester.tap(find.byKey(Key("${testKey3.toString()}-ADD")));

      // Rebuild the widget after the state has changed.
      await tester.pump();

      // Expect the cart badge value to be 2.
      expect(find.text("2"), findsOneWidget);
    });
  });
}
