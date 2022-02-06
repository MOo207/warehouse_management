import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_management/UI/argument/transaction_details_args.dart';
import 'package:warehouse_management/UI/widgets/custom_fab_widget.dart';
import 'package:warehouse_management/UI/widgets/filters_dialog.dart';
import 'package:warehouse_management/UI/widgets/in_out_bound_dialog.dart';
import 'package:warehouse_management/UI/widgets/transaction_card_widget.dart';
import 'package:warehouse_management/extensions/get_item_by_id.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/providers/item_provider.dart';
import 'package:warehouse_management/providers/transaction_provider.dart';

import 'widgets/search_widget.dart';

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
    ItemProvider itemProvider = Provider.of<ItemProvider>(context);
    context.watch<TransactionProvider>().getTransactions();

    context.watch<ItemProvider>().getItems();

    final controller = FloatingSearchBarController();

    context
        .watch<TransactionProvider>()
        .getTransactionsWithFilters(transactionProvider.filters);

    @override
    void dispose() {
      if (!controller.isClosed) {
        controller.dispose();
      }
      super.dispose();
    }

    buildResultList(transactions) {
      return transactionProvider.filters.isEmpty
          ? ListView.builder(
              itemCount: transactions.transactionList.length,
              itemBuilder: (context, index) {
                int itemId = transactions.transactionList[index].itemId;
                Item item = itemProvider.itemList.getItemById(itemId);
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, '/transactionDetails',
                      arguments: TransactionsDetailsArgument(
                          transactions.transactionList[index], item)),
                  child: TransactionCardWidget(
                    transaction: transactions.transactionList[index],
                    item: item,
                    index: index,
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.transactionsFilters.length,
              itemBuilder: (context, index) {
                int itemId = transactions.transactionsFilters[index].itemId;
                Item item = itemProvider.itemList.getItemById(itemId);
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, '/transactionDetails',
                      arguments: TransactionsDetailsArgument(
                          transactions.transactionsFilters[index], item)),
                  child: TransactionCardWidget(
                    transaction: transactions.transactionsFilters[index],
                    item: item,
                    index: index,
                  ),
                );
              },
            );
    }

    buildSearchList(List<Transaction> transactions) {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          int? itemId = transactions[index].itemId;
          Item item = itemProvider.itemList.getItemById(itemId!);
          return InkWell(
            onTap: () => Navigator.pushNamed(context, '/transactionDetails',
                arguments:
                    TransactionsDetailsArgument(transactions[index], item)),
            child: TransactionCardWidget(
              transaction: transactions[index],
              item: item,
              index: index,
            ),
          );
        },
      );
    }

    Widget buildSearchBar() {
      final actions = [
        FloatingSearchBarAction(
          child: CircularButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              List<int> newFilters = await filtersDialog(context) ?? [];
              transactionProvider.setFilters(newFilters);
              print(newFilters);
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(),
      ];

      return Consumer<TransactionProvider>(
        builder: (context, model, _) => FloatingSearchBar(
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
          onQueryChanged: model.searchTransaction,
          scrollPadding: EdgeInsets.zero,
          transition: CircularFloatingSearchBarTransition(spacing: 16),
          isScrollControlled: true,
          builder: (context, _) =>
              buildSearchList(model.transactionsSearchResult),
          body: model.transactionList.isEmpty
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
                      padding: EdgeInsets.only(top: 60),
                      child: buildResultList(model),
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
        body: buildSearchBar(),
      );
    });
  }
}
