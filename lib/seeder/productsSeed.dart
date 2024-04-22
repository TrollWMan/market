import 'package:market/db/banco.dart';
import 'package:market/model/products.dart';
import 'package:faker_dart/faker_dart.dart';

class ProductsSeed {
  void seedProduct() async {
      final db = await Banco.instance.database;
      Products prod = Products(null, null, null); //corrigir isso
      final faker = Faker.instance;

      for (var i = 0; i < 10; i++) {
        prod.name = faker.commerce.productName();
        prod.price = faker.datatype.float(min: 0, max: 100);

        db.rawInsert(""" 
          INSERT OR REPLACE INTO products(name, price)
          VALUES(
            '${prod.name}',
            '${prod.price}'
          )"""
        );
    }   
  }
}

