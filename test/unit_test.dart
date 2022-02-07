// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/services/hive_service.dart';
import 'package:warehouse_management/services/item_service.dart';
import 'package:warehouse_management/services/transaction_service.dart';
import 'package:warehouse_management/extensions/index_by_id_extension.dart';

void main() {
  ItemService itemService = ItemService();
  HiveService hiveService = HiveService();
  TransactionService transactionService = TransactionService();
  // Dummy item to test
  Item dummyItem = Item(
    id: 666,
    name: "item1",
    description: "item1 description",
    sku: "asdasd",
    price: "10",
    image: "image1",
  );

  // Dummy transaction to test
  Transaction dummyTransaction = Transaction(
      id: 1,
      type: "inbound",
      itemId: 2,
      quantity: 45,
      inbound_at: DateTime.tryParse("2012-02-27 11:00:00") ?? DateTime.now(),
      outbound_at: DateTime.tryParse("2012-02-27 13:27:00") ?? DateTime.now());

  group("Hive service init and boxes.", () {
    test("Hive Init", () async {
      bool hiveInitResult = await hiveService.initHive();
      expect(hiveInitResult, true);
    });

    test("Hive open Items box", () async {
      Box<Item> willOpenBox = await itemService.openItemsBox();
      expect(willOpenBox, isNotNull);
    });

    test("Hive open Transactions box", () async {
      Box<Transaction> willOpenBox =
          await transactionService.openTransactionsBox();
      expect(willOpenBox, isNotNull);
    });
    test("Hive clear boxes", () async {
      bool isDeletedBox = await hiveService.deleteOpenBoxes();

      expect(isDeletedBox, true);
    });
  });

  group("Itmes group test", () {
    test("Add item", () async {
      bool isItemAdded = await itemService.addItem(dummyItem);

      expect(
        isItemAdded,
        true,
      );
    });

    test("Update item", () async {
      List<Item> itemsList = await itemService.getItems();
      int index = itemsList.getIndexById(dummyItem.id!);
      bool isUpdated = await itemService.updateItem(index, dummyItem);

      expect(isUpdated, true);
    });
    test("Get items", () async {
      List<Item> itemsList = await itemService.getItems();
      expect(itemsList, isNotNull);
    });

    test("Delete item", () async {
      List<Item> itemsList = await itemService.getItems();

      int index = itemsList.indexOf(dummyItem);

      bool isItemDeleted = await itemService.deleteItem(index);

      expect(isItemDeleted, true);
    });
  });

  group("Transactions group test", () {
    test("Add Transaction", () async {
      bool isItemAdded =
          await transactionService.addTransaction(dummyTransaction);

      expect(
        isItemAdded,
        true,
      );
    });

    test("Update transaction", () async {
      List<Transaction> transactionList =
          await transactionService.getTransactions();
      int index = transactionList.getIndexById(dummyTransaction.id!);
      bool isUpdated =
          await transactionService.updateTransaction(index, dummyTransaction);
      expect(isUpdated, true);
    });
    test("Get transactions", () async {
      List<Transaction> transactionList =
          await transactionService.getTransactions();
      expect(transactionList, isNotNull);
    });
    test("Search for transaction success", () async {
      List<Transaction> transactionList =
          await transactionService.getTransactions();
      List<dynamic> resultTransaction = transactionService.searchForTransaction(dummyTransaction.type, transactionList);
      expect(resultTransaction.length, 1);
      expect(resultTransaction[0].type, dummyTransaction.type);
    });
    test("Search for transaction fail", () async {
      List<Transaction> transactionList =
          await transactionService.getTransactions();
      List<dynamic> resultTransaction = transactionService.searchForTransaction("outbound", transactionList);
      expect(resultTransaction.length, 0);
    });

    test("Delete transaction", () async {
      List<Transaction> transactionList =
          await transactionService.getTransactions();

      int index = transactionList.indexOf(dummyTransaction);

      bool isItemDeleted = await transactionService.deleteTransaction(index);

      expect(isItemDeleted, true);
    });
  });
}
