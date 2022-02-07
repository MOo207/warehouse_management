import 'dart:io';

import 'package:flutter/material.dart';
import 'package:warehouse_management/models/items/item_model.dart';

class ItemCardWidget extends StatelessWidget {
  final Item? item;
  final int? index;
  const ItemCardWidget({Key? key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            // child: Image.network("https://picsum.photos/100?image=11")),
            child: Image(
              height: 100,
              width: 100,
              image: item!.image== null || item!.image!.isEmpty
                  ? AssetImage("assets/placeholder.png")
                  : FileImage(File(item!.image!)) as ImageProvider,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
          )
        ],
      ),
    );
  }
}
