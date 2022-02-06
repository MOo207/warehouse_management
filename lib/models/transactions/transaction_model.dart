// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'transaction_model.g.dart';


@HiveType(typeId: 1)
class Transaction {
  @HiveField(0)
  final int? id;
  
  @HiveField(1)
  final String? type;

  @HiveField(2)
  final int? itemId;

  @HiveField(3)
  final int? quantity;

  @HiveField(4)
  final DateTime? inbound_at;

  @HiveField(5)
  final DateTime? outbound_at;

  Transaction({this.id, this.type, this.itemId, this.quantity, this.inbound_at, this.outbound_at});
}
