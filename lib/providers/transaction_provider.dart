import 'package:flutter/material.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/services/transaction_service.dart';

class TransactionProvider with ChangeNotifier {
  TransactionService transactionService = TransactionService();

  List _transactionsList = <Transaction>[];

  List get transactionList => _transactionsList;

  List _transactionsOperationList = <Transaction>[];

  List get transactionOperationList => _transactionsOperationList;

  getTransactions() async {
    final list = await transactionService.getTransactions();
    _transactionsList = list;
    notifyListeners();
  }

  updateTransaction(int index, Transaction transaction) async {
    await transactionService.updateTransaction(index, transaction);
    notifyListeners();
  }

  deleteTransaction(int index, Transaction transaction) async {
    _transactionsList.remove(transaction);
    // delete item from operation list also
    transactionOperationList.remove(transaction);
    await transactionService.deleteTransaction(index);
    notifyListeners();
  }

  List<int> _filters = <int>[];
  void setFilters(List<int> newFilters) {
    _filters = newFilters;
    notifyListeners();
  }

  List<int> get filters => _filters;

  searchForTransaction(String? query) async {
    List<Transaction> list = transactionService.searchForTransaction(
        query, _transactionsList as List<Transaction>);
    _transactionsOperationList = list;
    notifyListeners();
  }

  addTransaction(Transaction transaction) async {
    await transactionService.addTransaction(transaction);
    notifyListeners();
  }

  transactionsWithFilter(List<int> filters) async {
    if (filters.isNotEmpty) {
      _transactionsOperationList = _transactionsList;
      switch (filters[0]) {
        case 0:
          _transactionsOperationList
              .sort((a, b) => a.quantity!.compareTo(b.quantity!));
          break;
        case 1:
          _transactionsOperationList
              .sort((b, a) => a.quantity!.compareTo(b.quantity!));
          break;
        case 2:
          _transactionsOperationList.sort((a, b) => a.type!.compareTo(b.type!));
          break;
        case 3:
          _transactionsOperationList.sort((b, a) => a.type!.compareTo(b.type!));
          break;
        case 4:
          _transactionsOperationList
              .sort((a, b) => a.inbound_at!.compareTo(b.inbound_at!));
          break;
        case 5:
          _transactionsOperationList
              .sort((a, b) => a.outbound_at!.compareTo(b.outbound_at!));
          break;
        default:
      }
      return _transactionsOperationList;
    } else {
      return _transactionsList;
    }
  }

  // addOrUpdateTransaction(Transaction transaction) async {
//     var box = await Hive.openBox<Transaction>(_transactionsBox);

//     final Map transactionsMap = box.toMap();
//     int exist = -1;
//     transactionsMap.forEach((key, value) {
//       if (value.id == transaction.id) exist = transaction.id!;
//     });

//     if (exist == -1) {
//       addTransaction(transaction);
//       await showToastMessage("New Transaction added!");
//     } else {
//       int index = indexFromId(transaction.id!);
//       updateTransaction(index, transaction);
//       await showToastMessage("Transaction at index $index has been Updated!");
//     }
//   }

}
