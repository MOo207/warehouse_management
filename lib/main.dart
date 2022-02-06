import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/argument/transaction_details_args.dart';

import 'package:warehouse_management/UI/transactions_screen.dart';
import 'package:warehouse_management/UI/items_screen.dart';
import 'package:warehouse_management/UI/transaction_details_screen.dart';
import 'package:warehouse_management/providers/item_provider.dart';
import 'package:warehouse_management/providers/transaction_provider.dart';
import 'package:warehouse_management/services/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().initHive();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ItemProvider>(
      create: (context) => ItemProvider(),
    ),
    ChangeNotifierProvider<TransactionProvider>(
      create: (context) => TransactionProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warehouse Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0.4,
          color: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      initialRoute: "/transactions",
      routes: {
        "/transactions": (context) => const TransactionsScreen(),
        "/items": (context) => const ItemsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/transactionDetails") {
          final args = settings.arguments as TransactionsDetailsArgument;
          return MaterialPageRoute(
            builder: (context) => TransactionDetailsScreen(
              transaction: args.transaction,
              item: args.item,
            ),
          );
        }
      },
    );
  }
}
