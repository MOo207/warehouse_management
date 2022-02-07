import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/services/hive_service.dart';
import 'package:warehouse_management/services/transaction_service.dart';

class ItemService {
  static final ItemService _singleton = ItemService._internal();

  factory ItemService() {
    return _singleton;
  }

  ItemService._internal();

  openItemsBox() async {
    try {
      final box = await HiveService().openBox<Item>('items');
      return box;
    } catch (e) {
      return null;
    }
  }

  addItem(Item item) async {
    try {
      final box = await openItemsBox();
      box.add(item);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateItem(int index, Item item) async {
    try {
      final box = await openItemsBox();
      await box.putAt(index, item);
      return true;
    } catch (e) {
      return false;
    }
  }

  getItems() async {
    try {
    final box = await openItemsBox();
    return box!.values.toList();
    } catch (e) {
      return null;
    }
  }

  deleteItem(int index) async {
    try {
      final box = await openItemsBox();
      await box!.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }
  deleteItemWithItsTransactions(int index) async {
    try {
      final box = await openItemsBox();
      final item = box!.getAt(index);
      final transactions = await TransactionService().getTransactions();
      for (var transaction in transactions) {
        transaction as Transaction;
        if (transaction.itemId == item.id) {
          await TransactionService().deleteTransaction(transaction.id!);
        }
      }
      await box!.deleteAt(index);
      await showToastMessage("Item deleted successfully with its transactions");
      return true;
    } catch (e) {
      return false;
    }
  }

}
