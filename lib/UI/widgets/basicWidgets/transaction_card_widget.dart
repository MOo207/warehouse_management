import 'package:flutter/material.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';

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
    return Card(
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
                  item!.name != null ? item!.name! : "name",
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  item!.sku != null ? item!.sku! : "sku",
                  style: const TextStyle(fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  item!.description != null ? item!.description! : "description",
                  style: const TextStyle(fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  item!.price != null ? item!.price!  + " SR" : "price"  + " SR",
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
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    transaction!.type == "Inbound"
                        ? const Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                          )
                        : const Icon(
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
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String showDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
