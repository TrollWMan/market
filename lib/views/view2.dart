import 'package:flutter/material.dart';
import 'package:market/model/products.dart';
import 'package:provider/provider.dart';
import 'package:market/provider/purchaseCarProvider.dart';

class View2 extends StatefulWidget {
  const View2({Key? key}) : super(key: key);

  @override
  _View2State createState() => _View2State();
}

class _View2State extends State<View2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        automaticallyImplyLeading: true,
        title: const Text("Carrinho"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: Provider.of<PurchaseCarProvider>(context, listen: false).products?.length ?? 0,
          itemBuilder: (context, index) {
            List<Products> data = Provider.of<PurchaseCarProvider>(context, listen: false).products!;
            return ListTile(
              title: Text('Nome: ${data[index].name.toString()}'),
              subtitle: Text('Preço: ${data[index].price.toString()}'),
              trailing: Text('Quantidade\n${data[index].quantity?.toInt()}', style: const TextStyle(fontSize: 14),),
            );
          },
        ),
      ),
    );
  }
}
