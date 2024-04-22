import 'package:flutter/material.dart';
import 'package:market/model/products.dart';
import 'package:provider/provider.dart';
import 'package:market/provider/purchaseCarProvider.dart';

class View1 extends StatefulWidget {
  const View1({Key? key}) : super(key: key);

  @override
  _View1State createState() => _View1State();
}

class _View1State extends State<View1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        automaticallyImplyLeading: false,
        title: const Text("Compras"),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/view2');
            },
            icon: Badge(
              label: Text('${Provider.of<PurchaseCarProvider>(context, listen: true).products?.length ?? 0}'),
              child: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Expanded(
        flex: 9,
        child: FutureBuilder<List<Products?>>(
          future: Products.recuperarProdutos(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Expanded(
                flex: 9,
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              List<Products?> data = snapshot.data!;
              return Expanded(
                flex: 9,
                child: Card(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Nome: ${data[index]!.name.toString()}'),
                        subtitle: Text('Preço: ${data[index]!.price.toString()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.shopping_bag),
                          onPressed: () {
                            Provider.of<PurchaseCarProvider>(context, listen: false).addProduct(data[index]!);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
