import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/transaction_details_screen.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/providers/item_provider.dart';


class SearchWidget extends SearchDelegate<Transaction> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Transaction()); // for closing the search page and going back
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(query: query);
  }
}

class SearchFinder extends StatelessWidget {
  final String? query;

  const SearchFinder({Key? key, this.query}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.watch<ItemProvider>().getItems();
    ItemProvider databaseProvider = Provider.of<ItemProvider>(context);
    return FutureBuilder<List<Item>>(
      future: databaseProvider.OnQueryChangedCallback(query!),
      builder: (context, snapshot) {
        ///* this is where we filter data

        return snapshot.data == null
            ? Center(
                child: Text(
                  'No results found !',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                      ),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // passing as a custom list
                  final Item contactListItem = snapshot.data![index];

                  return ListTile(
                    onTap: () {
                      ///* This is where we update index so that we could go to that screen
                      // var selectedContactIndex =
                      //     Provider.of<ItemProvider>(context, listen: false).transactionList
                      //         .indexOf(results[index]);
                      // databaseProvider
                      //     .updateTransaction(selectedContactIndex, );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransactionDetailsScreen()));
                    },
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contactListItem.name.toString(),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          contactListItem.id.toString(),
                          textScaleFactor: 1.0,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              !.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }
}