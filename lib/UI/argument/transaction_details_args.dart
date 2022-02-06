import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';

class TransactionsDetailsArgument {
 final Transaction? transaction;
  final Item? item;

  const TransactionsDetailsArgument(this.transaction, this.item);
}