import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r"\d"))],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isNotEmpty && int.tryParse(value) == null) {
                          return "Please enter a valid ID";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
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
                       inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a name";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a price";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a sku";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a description";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
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
            );
          }),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty &&
                    skuController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
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
                } else {
                  showToastMessage('Please fill all the fields');
                }
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
