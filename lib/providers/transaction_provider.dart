import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  final String _transactionsBox = 'transactions';

  List _transactionsList = <Transaction>[];

  List get transactionList => _transactionsList;



  indexFromId(int id) {
    return _transactionsList.indexWhere((transaction) => transaction.id == id);
  }

   getTransactions() async {
    final box = await Hive.openBox<Transaction>(_transactionsBox);

    _transactionsList = box.values.toList();

    notifyListeners();
  }

  updateTransaction(int index, Transaction transaction) {
    final box = Hive.box<Transaction>(_transactionsBox);

    box.putAt(index, transaction);

    notifyListeners();
  }

  deleteTransaction(int index) {
    final box = Hive.box<Transaction>(_transactionsBox);

    box.deleteAt(index);

    getTransactions();

    notifyListeners();
  }

  List<int> _filters = <int>[];
   void setFilters(List<int> newFilters){
      _filters = newFilters;
      notifyListeners();
   }
  List<int> get filters => _filters;

  List<Transaction> _transactionsSearchResult = <Transaction>[];

  List<Transaction> get transactionsSearchResult => _transactionsSearchResult;

  searchTransaction(String? query) {
    if (query!.isEmpty) {
      getTransactions();
      _transactionsSearchResult = _transactionsList as List<Transaction>;
      return _transactionsSearchResult;
    } else {
      if (int.tryParse(query) != null) {
        _transactionsSearchResult = _transactionsList.where((transaction) {
          transaction as Transaction;
          return transaction.quantity.toString().contains(query);
        }).toList() as List<Transaction>;

        return _transactionsSearchResult;
      } else if (DateTime.tryParse(query) != null) {
        _transactionsSearchResult = _transactionsList
            .where((transaction) =>
                transaction.inbound_at.contains(DateTime.parse(query)))
            .toList() as List<Transaction>;
        return _transactionsSearchResult;
      } else {
        _transactionsSearchResult = _transactionsList.where((transaction) {
          transaction as Transaction;
          return transaction.type!.toLowerCase().contains(query.toLowerCase());
        }).toList() as List<Transaction>;
        return _transactionsSearchResult;
      }
    }
  }

  addTransaction(Transaction transaction) async {
    var box = await Hive.openBox<Transaction>(_transactionsBox);

    box.add(transaction);

    notifyListeners();
  }

  List<Transaction> _transactionsFilters = <Transaction>[];

  List<Transaction> get transactionsFilters => _transactionsFilters;

  getTransactionsWithFilters(List<int> filters) async {
    final box = await Hive.openBox<Transaction>(_transactionsBox);

    if (filters.isNotEmpty) {
      _transactionsFilters = box.values.toList();

      switch (filters[0]) {
        case 0:
          _transactionsFilters
              .sort((a, b) => a.quantity!.compareTo(b.quantity!));
          break;
        case 1:
         _transactionsFilters
              .sort((b, a) => a.quantity!.compareTo(b.quantity!));
          break;
        case 2:
        _transactionsFilters
              .sort((a, b) => a.type!.compareTo(b.type!));
          break;
        case 3:
        _transactionsFilters
              .sort((b, a) => a.type!.compareTo(b.type!));
          break;
        case 4:
         _transactionsFilters
              .sort((a, b) => a.inbound_at!.compareTo(b.inbound_at!));
          break;
        case 5:
        _transactionsFilters
              .sort((a, b) => a.outbound_at!.compareTo(b.outbound_at!));
          break;
        default:
      }

      notifyListeners();
    } else {
      _transactionsFilters = box.values.toList();
      notifyListeners();
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
