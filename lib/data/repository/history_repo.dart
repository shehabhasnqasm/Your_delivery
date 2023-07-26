import 'package:food_delivary/data/sqflit_db/sqflite_db.dart';
import 'package:food_delivary/model/history_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryRepo {
  SqfliteDB sqfliteDB;
  HistoryRepo({required this.sqfliteDB});
  List<CartModelHistory> cartHistoryList = [];

  Future<List<CartModelHistory>> getCartHistoryList(String tableName) async {
    cartHistoryList = [];
    Database? dataBase = await sqfliteDB.db;
    List<Map<String, Object?>> response = await dataBase!.query(tableName);

    for (int i = 0; i < response.length; i++) {
      cartHistoryList.add(CartModelHistory.fromMap(response[i]));
    }
    return cartHistoryList;
  }

//-----------------------------------------------------------
  Future<int> insert(
    String tableName,
    Map<String, Object?> values,
  ) async {
    Database? dataBase = await sqfliteDB.db;
    int response = await dataBase!
        .insert(tableName, values, conflictAlgorithm: ConflictAlgorithm.ignore);
    return response;
  }

//-----------------------------------------------------------
  Future<int> update(
      String tableName, Map<String, Object?> values, String? where) async {
    Database? dataBase = await sqfliteDB.db;
    int response = await dataBase!.update(tableName, values, where: where);
    return response;
  }

//-----------------------------------------------------------
  Future<int> delete(
      String tableName, String? where, List<Object?>? whereArgs) async {
    Database? dataBase = await sqfliteDB.db;
    int response =
        await dataBase!.delete(tableName, where: where, whereArgs: whereArgs);
    return response;
  }

//-----------------------------------------------------------
  deleteTheDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'historydb.db');
    bool exist = await databaseExists(path);
    if (exist == true) {
      await deleteDatabase(path);
      print("exist =>$exist ,,, db deleted");
    }
    print("exist =>$exist ,,, ");
  }
  //-----------------------------------------------------------
}
