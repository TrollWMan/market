import 'package:flutter/material.dart';
import 'package:market/db/banco.dart';
import 'package:market/seeder/productsSeed.dart';
import 'package:provider/provider.dart';
import 'package:market/provider/purchaseCarProvider.dart';
import 'package:market/views/view1.dart';
import 'package:market/views/view2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Banco.deleteDatabaseIfExists();

  ProductsSeed seeder = ProductsSeed();
  seeder.seedProduct();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PurchaseCarProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Market",
        initialRoute: '/view1',
        routes: {
          '/view1': (context) => const View1(),
          '/view2': (context) => const View2(),
        },
      ),
    );
  }
}