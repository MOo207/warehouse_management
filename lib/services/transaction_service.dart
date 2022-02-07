import 'package:warehouse_management/models/transactions/transaction_model.dart';
import 'package:warehouse_management/services/hive_service.dart';

class TransactionService {
  static final TransactionService _singleton = TransactionService._internal();

  factory TransactionService() {
    return _singleton;
  }

  TransactionService._internal();

  openTransactionsBox() async {
    final box = await HiveService().openBox<Transaction>('transactions');
    return box;
  }

  addTransaction(Transaction transaction) async {
    try {
      final box = await openTransactionsBox();
      box.add(transaction);
      return true;
    } catch (e) {
      return false;
    }
  }

  getTransactions() async {
    final box = await openTransactionsBox();
    return box.values.toList();
  }

  updateTransaction(int index, Transaction transaction) async {
    try {
      final box = await openTransactionsBox();
      box.putAt(index, transaction);

      return true;
    } catch (e) {
      return false;
    }
  }

  deleteTransaction(int index) async {
    try {
      final box = await openTransactionsBox();
      box.deleteAt(index);
      return true;
    } catch (e) {
      return false;
    }
  }

  searchForTransaction(String? query, List<Transaction> searchList) {
    if (int.tryParse(query!) != null) {
      return searchList.where((transaction) {
        transaction;
        return transaction.quantity.toString().contains(query);
      }).toList();
    } else if (DateTime.tryParse(query) != null) {
      return searchList
          .where((transaction) =>
              transaction.inbound_at!.toString().contains(query))
          .toList();
    } else {
      return searchList.where((transaction) {
        transaction;
        return transaction.type!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  // List<Transaction> transactionsWithFilter(List<int> filters,
  //     List<Transaction> sourceList, List<Transaction> resultList) {
  //   resultList = sourceList;
  //   switch (filters[0]) {
  //     case 0:
  //       resultList.sort((a, b) => a.quantity!.compareTo(b.quantity!));
  //       break;
  //     case 1:
  //       resultList.sort((b, a) => a.quantity!.compareTo(b.quantity!));
  //       break;

  //     case 2:
  //       resultList.sort((a, b) => a.type!.compareTo(b.type!));
  //       break;

  //     case 3:
  //       resultList.sort((b, a) => a.type!.compareTo(b.type!));
  //       break;

  //     case 4:
  //       resultList.sort((a, b) => a.inbound_at!.compareTo(b.inbound_at!));
  //       break;

  //     case 5:
  //       resultList.sort((a, b) => a.outbound_at!.compareTo(b.outbound_at!));
  //       break;

  //     default:
  //   }
  //   print(resultList);
  //   return resultList;
  // }

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
