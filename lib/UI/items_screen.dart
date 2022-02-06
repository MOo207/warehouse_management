import 'package:flutter/material.dart';
import 'package:warehouse_management/UI/widgets/custom_bottom_sheet.dart';
import 'package:warehouse_management/UI/widgets/custom_fab_widget.dart';
import 'package:warehouse_management/UI/widgets/item_card_widget.dart';
import 'package:warehouse_management/providers/item_provider.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.watch<ItemProvider>().getItems();
    final double width = MediaQuery.of(context).size.width;

    return Consumer<ItemProvider>(builder: (context, items, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Items'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: CustomFABWidget(
          heroTag: "0",
          // onPressed: () => openModalBottomSheet(context),
          onPressed: () {
            openModalBottomSheet(context);
          },
          label: "Add Item",
          icon: Icons.add,
          width: width * 0.9,
        ),
        body: Column(
          children: [
            Expanded(
              child: items.itemList.isEmpty
                  ? const Center(
                      child: Text("No Items"),
                    )
                  : ListView.builder(
                      itemCount: items.itemList.length,
                      itemBuilder: (context, index) {
                        return ItemCardWidget(
                          item: items.itemList[index],
                          index: index,
                        );
                      },
                    ),
            ),
          ],
        ),
      );
    });
  }
}
