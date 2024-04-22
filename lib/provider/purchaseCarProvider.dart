import 'package:flutter/material.dart';
import 'package:market/model/products.dart';

class PurchaseCarProvider extends ChangeNotifier {
  List<Products>? products;

  PurchaseCarProvider({
    this.products,
  });

  void addProduct(Products product) {
    products ??= [];
    
    if (product.quantity == 0){
      product.quantity = 1;
    }
      
    // Verifica se já existe um produto com o mesmo nome e preço
    var existingProduct = products!.firstWhere(
      (p) => p.name == product.name && p.price == product.price,
      orElse: () => Products('', 0, 0), // Retorna um objeto Products vazio se nenhum produto for encontrado
    );

    if (existingProduct.name!.isNotEmpty) {
      // Se o produto já existe, aumenta a quantidade
      existingProduct.quantity = (existingProduct.quantity ?? 0) + 1;
    } else {
      // Caso contrário, adiciona o produto à lista
      products!.add(product);
    }

    notifyListeners();
  }
}
