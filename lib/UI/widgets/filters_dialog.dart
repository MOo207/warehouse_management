import 'package:flutter/material.dart';

class FilterEntry {
  const FilterEntry(this.name, this.value);
  final String name;
  final int value;
}


Future filtersDialog(context) async {
  
  final List<FilterEntry> _cast = <FilterEntry>[
    const FilterEntry('Quntity Asc', 0),
    const FilterEntry('Quantity Desc', 1),
    const FilterEntry('Inbound', 2),
    const FilterEntry('Outbound', 3),
    const FilterEntry('In Date', 4),
    const FilterEntry('Out Date', 5),
  ];
  final List<int> _filters = <int>[];
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        
        return AlertDialog(
          title: const Center(child: Text("Filters Dialog")),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ..._cast.map((FilterEntry entry) {
                    return FilterChip(
                      label: Text(entry.name),
                      selected: _filters.contains(entry.value),
                      onSelected: (bool value) {
                        setState(() {
                          if (value) {
                            _filters.add(entry.value);
                          } else {
                            _filters.remove(entry.value);
                          }
                        });
                      },
                    );
                  }).toList(),
                 
                 IconButton(onPressed: 
                 (){
                   _filters.clear();
                  setState(() {
                   
                  });
                 }, icon: Icon(Icons.clear))
                ],
              ),
            );
          }),
          actions: [
             ElevatedButton(
               onPressed: (){
                  Navigator.pop(context, _filters);
               },
               child: const Text('Save'),
             ),
             FlatButton(
                 onPressed: () {
                   Navigator.pop(context);
                 },
                 child: const Text('Cancel'))
          ],
        );
      });
      
}
