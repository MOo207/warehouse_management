import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/providers/item_provider.dart';


class ItemCardWidget extends StatelessWidget {
  final Item? item;
  final int? index;
  const ItemCardWidget({Key? key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    return Dismissible(
      key: Key(item!.id.toString()),
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
      ),
      onDismissed: (direction) async {
        itemProvider.deleteItem(index!);
        await showToastMessage("Item at index $index has been Deleted!");
      },
      child: Card(
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
              child: FadeInImage.assetNetwork(
                height: 100,
                width: 100,
                placeholder: "assets/loading.gif",
                image: 'https://picsum.photos/100?image=9',
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
      ),
    );
  }
}
