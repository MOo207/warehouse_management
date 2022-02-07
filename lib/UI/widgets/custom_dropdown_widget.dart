import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class CustomDropDown extends StatefulWidget {
  final List<Map<String, dynamic>>? items;
  final Function(String)? onChange;
  const CustomDropDown({Key? key, this.items, this.onChange}) : super(key: key);

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  TextEditingController? _controller;

  //String _initialValue;
  String _valueChanged = '';
  String _valueToValidate = '';
  String _valueSaved = '';

  List<Map<String, dynamic>>? _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
    //_initialValue = 'starValue';
    _controller = TextEditingController(text: '2');

    _getValue();
  }

  /// This implementation is just to simulate a load data behavior
  /// from a data base sqlite or from a API
  void _getValue() {
    //_initialValue = 'circleValue';
    if (widget.items!.isNotEmpty){
    _controller?.text = widget.items!.first['label'] ;
    } else {
      _controller?.text = 'No Items';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectFormField(
      type: SelectFormFieldType.dialog,
      controller: _controller,
      //initialValue: _initialValue,
      icon: const Icon(Icons.inventory),
      labelText: 'Item',
      changeIcon: true,
      dialogTitle: 'Pick an item',
      dialogCancelBtn: 'CANCEL',
      enableSearch: true,
      dialogSearchHint: 'Search item',
      items: _items,
      onChanged: widget.onChange,
      validator: (val) {
        setState(() => _valueToValidate = val ?? '');
        return null;
      },
      onSaved: (val) {
       
       setState(() => _valueSaved = val ?? '');
      }
    );
  }
}
