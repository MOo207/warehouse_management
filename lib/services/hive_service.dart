import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test/test.dart';
import 'package:warehouse_management/models/items/item_model.dart';
import 'package:warehouse_management/models/transactions/transaction_model.dart';

class HiveService {
  static final HiveService _singleton = HiveService._internal();

  factory HiveService() {
    return _singleton;
  }
  HiveService._internal();

  Future<bool> initHive() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      Hive.registerAdapter(ItemAdapter());
      Hive.registerAdapter(TransactionAdapter());
      return true;
    } catch (e) {
      Exception(e);
      return false;
    }
  }

  Future<Box<T>> openBox<T>(String boxName) async {
    final box = await Hive.openBox<T>(boxName);
    return box;
  }

  Future<void> closeBox() async {
    await Hive.close();
  }

  Future<bool> deleteOpenBoxes() async {
    await Hive.deleteFromDisk();
    return true;
  }
}
