import 'dart:io';

import 'package:flutter/material.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Transaction? transaction;
  final Item? item;
  const TransactionDetailsScreen({Key? key, this.transaction, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: Container(
        height: height * 0.5,
        margin: const EdgeInsets.all(18),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Image(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        // ignore: unnecessary_null_comparison
                        image: item!.image! == null || item!.image!.isEmpty? const AssetImage("assets/placeholder.png")  :FileImage(File(item!.image!)) as ImageProvider,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: width * 0.08),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      transaction!.quantity!.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item!.price! + " SR",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      "Price",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: width * 0.35),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Inbounded"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      showDate(transaction!.inbound_at!),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      "Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: width * 0.27),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("Outbounded"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      showDate(transaction!.outbound_at!),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      "Time",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: width * 0.27),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String showDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}              ${date.hour}:${date.minute}";
  }
}
