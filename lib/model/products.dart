import 'package:market/db/banco.dart';

class Products {
  String? name;
  double? quantity;
  double? price;

  Products(
    this.name,
    this.quantity,
    this.price,
  );

  static Future<List<Products>> recuperarProdutos() async {
    final db = await Banco.instance.database;
    List<Map<String, dynamic>> lista =
        await db.rawQuery('SELECT * FROM products');
    List<Products> produtos = [];

    if (lista.isNotEmpty) {
      /*Map<String, dynamic> utemp = lista.first;
      Products produto = Products(utemp['name'].toString(), utemp['quantity'], utemp['quantity']);*/

      for (var item in lista) {
        Products produto = Products(
          item['name'].toString(),
          item['quantity'],
          item['price'],
        );
        produtos.add(produto);
      }
      return produtos;
    } else {
      throw Exception('Banco vazio');
    }
  }
}
