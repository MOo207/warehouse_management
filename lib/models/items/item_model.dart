import 'package:hive/hive.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item {
  @HiveField(0)
  final int? id;
  
  @HiveField(1)
  final String? name;
  
  @HiveField(2)
  final String? price;

  @HiveField(3)
  final String? sku;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final String? image;

  Item({this.id, this.price, this.sku, this.image, this.name, this.description});
}
