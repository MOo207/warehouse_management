import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/widgets/custom_toast_message.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/providers/item_provider.dart';

Future showInputDialog(context) {
  final itemProvider = Provider.of<ItemProvider>(context, listen: false);
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text("Input Dialog")),
          content: Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: idController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Id",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Name",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: priceController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Price",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: skuController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Sku",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Description",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    controller: imageController,
                    autofocus: true,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Item Image",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                int generated = DateTime.now().millisecondsSinceEpoch;
                Item addedItem = Item(
                    // id: int.parse(idController.text),
                    id: idController.text.isEmpty
                        ? generated
                        : int.parse(idController.text),
                    name: nameController.text,
                    price: priceController.text,
                    sku: skuController.text,
                    description: descriptionController.text,
                    image: imageController.text);
                Navigator.pop(context);
                itemProvider.addOrUpdateItem(addedItem);
                showToastMessage('Item added to inventory manually');
              },
              child: const Text('Save'),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
          ],
        );
      });
}
