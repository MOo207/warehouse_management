import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/argument/transaction_details_args.dart';
import 'package:warehouse_management/UI/widgets/basicWidgets/custom_fab_widget.dart';
import 'package:warehouse_management/UI/widgets/smallElements/custom_toast_message.dart';
import 'package:warehouse_management/UI/widgets/inputWidgets/filters_dialog.dart';
import 'package:warehouse_management/UI/widgets/inputWidgets/in_out_bound_dialog.dart';
import 'package:warehouse_management/UI/widgets/basicWidgets/transaction_card_widget.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/providers/item_provider.dart';
import 'package:warehouse_management/providers/transaction_provider.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);
    context.watch<ItemProvider>().getItems();
    context.watch<TransactionProvider>().getTransactions();

    final controller = FloatingSearchBarController();

    context
        .watch<TransactionProvider>()
        .transactionsWithFilter(transactionProvider.filters);

    @override
    // ignore: unused_element
    void dispose() {
      if (!controller.isClosed) {
        controller.dispose();
      }
      super.dispose();
    }

    buildResultList(transactionProvider, itemProvider) {
      List<Transaction>? listOfTransactions =
          transactionProvider.filters.isEmpty
              ? transactionProvider.transactionList
              : transactionProvider.transactionOperationList;
      return transactionProvider.transactionList.isEmpty ||
              itemProvider.itemList.isEmpty
          ? const Center(
            child: Text(
              'No Transactions Found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
          : ListView.builder(
              itemCount: listOfTransactions!.length,
              itemBuilder: (context, index) {
                Transaction transaction = listOfTransactions[index];
                int? itemId = transaction.itemId;
                List<Item> items = itemProvider.itemList as List<Item>;
                Item item = items.firstWhere((element) => element.id == itemId);

                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, '/transactionDetails',
                      arguments:
                          TransactionsDetailsArgument(transaction, item)),
                  child: Dismissible(
                    key: Key(listOfTransactions[index].id!.toString()),
                    background: Container(
                      color: Colors.red,
                      child: const Icon(Icons.delete),
                    ),
                    onDismissed: (direction) async {
                      transactionProvider.deleteTransaction(index, transaction);
                      await showToastMessage(
                          "Item at index $index has been Deleted!");
                    },
                    child: TransactionCardWidget(
                      transaction: listOfTransactions[index],
                      item: item,
                      index: index,
                    ),
                  ),
                );
              },
            );
    }

    buildSearchList(List<Transaction> transactions, itemProvider) {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          Transaction transaction = transactions[index];
          int? itemId = transaction.itemId;
          Item item = itemProvider.itemList.firstWhere((element) {
            element as Item;
            return element.id == itemId;
          });

          return InkWell(
            onTap: () => Navigator.pushNamed(context, '/transactionDetails',
                arguments:
                    TransactionsDetailsArgument(transactions[index], item)),
            child: TransactionCardWidget(
              transaction: transaction,
              item: item,
              index: index,
            ),
          );
        },
      );
    }

    Widget buildSearchBar(transactionProvider) {
      final actions = [
        FloatingSearchBarAction(
          child: CircularButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              List<int> newFilters = await filtersDialog(context) ?? [];
              transactionProvider.setFilters(newFilters);
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(),
      ];

      return Consumer2<TransactionProvider, ItemProvider>(
        builder: (context, transaction, item, _) => FloatingSearchBar(
          controller: controller,
          hint: 'Search for something',
          iconColor: Colors.grey,
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOutCubic,
          physics: const BouncingScrollPhysics(),
          axisAlignment: 0,
          openAxisAlignment: 0.0,
          actions: actions,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: transaction.searchForTransaction,
          scrollPadding: EdgeInsets.zero,
          transition: CircularFloatingSearchBarTransition(spacing: 16),
          isScrollControlled: true,
          builder: (context, _) =>
              transaction.transactionList.isEmpty || item.itemList.isEmpty
                  ? const Center(
                      child: Text(
                        'No Transactions',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : buildSearchList(
                      transaction.transactionOperationList as List<Transaction>,
                      item),
          body: transaction.transactionList.isEmpty || item.itemList.isEmpty
              ? const Center(
                  child: Text(
                    'No Transactions',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: buildResultList(transaction, item),
                    )),
                  ],
                ),
        ),
      );
    }

    return Consumer<TransactionProvider>(
        builder: (context, transactions, child) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomFABWidget(
              heroTag: "0",
              label: "  Send  ",
              icon: Icons.arrow_upward,
              onPressed: () => showInOutBoundForm(context, false),
            ),
            const SizedBox(width: 10),
            CustomFABWidget(
              heroTag: "1",
              label: "Receive",
              icon: Icons.arrow_downward,
              onPressed: () => showInOutBoundForm(context, true),
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text(
            'Transactions',
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/items'),
                icon: const Icon(
                  Icons.add_circle,
                )),
          ],

          // Other Sliver Widgets
        ),
        body: buildSearchBar(transactions),
      );
    });
  }
}
