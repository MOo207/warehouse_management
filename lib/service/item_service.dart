import 'package:hive/hive.dart';
import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';

class ItemService {
  final String _itemsBox = 'items';

  List _itemsList = <Item>[];

  List get itemList => _itemsList;

  indexFromId(int id) {
    return _itemsList.indexWhere((item) => item.id == id);
  }

  getItemById(int id) {
    return _itemsList.firstWhere((item) => item.id == id);
  }

  addOrUpdateItem(Item item) async {
    var box = await Hive.openBox<Item>(_itemsBox);

    final Map itemsMap = box.toMap();
    int exist = -1;
    itemsMap.forEach((key, value) {
      if (value.id == item.id) exist = item.id!;
    });

    if (exist == -1) {
      addItem(item);
      await showToastMessage("New Item added!");
    } else {
      int index = indexFromId(item.id!);
      updateItem(item, index);
      await showToastMessage("Item at index $index has been Updated!");
    }
  }

  Future<List<Item>> onQueryChangedCallback(String query) {
    if (query.isEmpty) {
      return Future.value(_itemsList as List<Item>);
    } else {
      _itemsList = _itemsList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Future.value(_itemsList as List<Item>);
    }
  }

  addItem(Item item) async {
    var box = await Hive.openBox<Item>(_itemsBox);

    box.add(item);
  }

  updateItem(Item item, int index) async {
    var box = await Hive.openBox<Item>(_itemsBox);

    box.putAt(index, item);
  }

  getItems() async {
    final box = await Hive.openBox<Item>(_itemsBox);

    _itemsList = box.values.toList();
    return _itemsList;
  }

  deleteItem(int index) {
    final box = Hive.box<Item>(_itemsBox);

    box.deleteAt(index);

    getItems();

    
  }
}
