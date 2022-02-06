import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/providers/transaction_provider.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transaction? transaction;
  final Item? item;
  final int? index;
  const TransactionCardWidget(
      {Key? key, this.transaction, this.index, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    return Dismissible(
      key: Key(transaction!.id.toString()),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) async {
        transactionProvider.deleteTransaction(index!);
        await showToastMessage("Item at index $index has been Deleted!");
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item!.name!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    item!.sku!,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    item!.description!,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    item!.price! + " SR",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        transaction!.type == "Inbound"
                            ? "Stock In"
                            : "Stock Out",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      transaction!.type == "Inbound"
                          ? Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    showDate(transaction!.outbound_at!),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String showDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
