import 'package:warehouse_management/UI/widgets/smallElements/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/providers/transaction_provider.dart';
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

}
