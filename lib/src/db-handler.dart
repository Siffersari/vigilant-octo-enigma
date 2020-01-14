import 'package:postgres/postgres.dart';

class Product {
  double price;
  String productName,description;

  Product({
    this.description,this.price,this.productName
  });
  @override
  String toString() {
    return "Name: $productName\n Price: $price\nDescription: $description\n";
  }
  Map toMap() => {
    "Name": productName,
    "Price": price,
    "Description": description
  };
}

class DbAdapter {
  PostgreSQLConnection connection;

  DbAdapter({
    this.connection
  });

  Future<List<Product>> getProducts(int limit) async {
    String query = 'SELECT name, price, description FROM products LIMIT $limit';
    var results = await connection.query(query);
    return results.map((row)=>Product(description: row[2],productName: row[0],price: row[1])).toList();
  }

  Future postProduct(Product product) async {
    String query = 'INSERT INTO products (name, description, price) VALUES (${product.productName}, ${product.description}, ${product.price})';

    var result = await connection.execute(query);

    return product;
  }
} 