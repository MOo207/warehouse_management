import 'package:flutter/material.dart';
import 'package:warehouse_management/UI/widgets/custom_add_item_dialog.dart';
import 'package:warehouse_management/UI/widgets/qr_scanner_widget.dart';

openModalBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.vertical(
          top:  Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) {
      return Wrap(
        
        children:  [
           ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text('From QR Code'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScanner()));
            },
          ),
           ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Manually'),
            onTap: () async {
              Navigator.pop(context);
             await showInputDialog(context);
            },
          ),
        ],
      );
    },
  );
}
