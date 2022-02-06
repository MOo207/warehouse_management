// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'dart:io';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive/hive.dart';
// import 'package:warehouse_management/models/items/item_model.dart';
// import 'package:warehouse_management/models/transactions/transaction_model.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:warehouse_management/service/item_service.dart';

// void main() {
//   group("Itmes group test", () {
//     test("Hive Init", () async {
//       Directory directory =
//           await path_provider.getApplicationDocumentsDirectory();
//       Hive.init(directory.path);
//       Hive.registerAdapter(ItemAdapter());
//       Hive.registerAdapter(TransactionAdapter());
//       await Hive.deleteFromDisk();
//     });

//      test("Add item", () async{
//     Item item = Item(
//       id: 1,
//       name: "item1",
//       description: "item1 description",
//       price: "10",
//       image: "image1",
//     );

//     ItemService itemService = ItemService();
    
//     await itemService.addItem(item);
    

//     expect(itemService.itemList.length, 1);
//   });
//   });
 
// }
