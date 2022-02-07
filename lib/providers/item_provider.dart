import 'package:flutter/material.dart';
import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/extensions/index_by_id_extension.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/services/item_service.dart';

class ItemProvider with ChangeNotifier {
  ItemService itemService = ItemService();

  List _itemsList = <Item>[];

  List get itemList => _itemsList;

  addOrUpdateItem(Item item) async {
    List<Item> items = await itemService.getItems();

    final Map itemsMap = items.asMap();
    int exist = -1;
    itemsMap.forEach((key, value) {
      if (value.id == item.id) exist = item.id!;
    });

    if (exist == -1) {
      itemService.addItem(item);
      notifyListeners();
      await showToastMessage("New Item added!");
    } else {
      int index = _itemsList.getIndexById(item.id!);
      await itemService.updateItem(index, item);
      notifyListeners();
      await showToastMessage("Item at index $index has been Updated!");
    }
  }

  addItem(Item item) async {
    itemService.addItem(item);
    notifyListeners();
  }

  updateItem(int index, Item item) async {
    itemService.updateItem(index, item);
    notifyListeners();
  }

  getItems() async {
    _itemsList = await itemService.getItems();
    notifyListeners();
  }

  deleteItem(int index) {
    itemList.removeAt(index);
    itemService.deleteItem(index);
    notifyListeners();
  }

  deleteItemWithItsTransactions(int index) async {
    itemList.removeAt(index);
    await itemService.deleteItemWithItsTransactions(index);
    notifyListeners();
  }
}
