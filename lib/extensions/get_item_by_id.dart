import 'package:warehouse_management/models/items/item_model.dart';

extension GetItemById on List<dynamic> {
  Item getItemById(int id) {
    return firstWhere((item) {
      item as Item;
      return item.id == id;
    });
  }
}
