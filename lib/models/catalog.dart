/* ************************************************ */
/* CatalogModel represent the catalog that contains */
/* all the products to display in the shop          */
/* ************************************************ */
class CatalogModel {
  // Products list of the catalog
  final List<Product> catalog;

  // Constructor
  CatalogModel({this.catalog});

  /// Get product by [id].
  Product getById(int id) => catalog.firstWhere((element) => element.id == id);

  // Get the list of products
  List<Product> get products => catalog;

  // Get the total number of products in the catalog
  int getSize() => catalog.length;
}

/* *************************************************** */
/* The class Product define a product in the catalog   */
/* *************************************************** */
class Product {
  final int id;
  final String name;
  final int unit;
  final int price;
  final String picture;
  int quantity = 1;

  Product({this.id, this.name, this.unit, this.price, this.picture});

  // Factory to contruct a Product from a json
  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      id: json['id'] as int,
      name: json['name'] as String,
      unit: json['unit'] as int,
      price: json['price'] as int,
      picture: json['picture'] as String,
    );
  }
}
