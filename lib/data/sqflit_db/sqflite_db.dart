import 'package:food_delivary/utils/app_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  String colId = "0";
  intialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'historydb.db');

    Database noteDb = await openDatabase(path,
        onCreate: _onCreate, version: 1); // onUpgrade: _onUpgrade
    return noteDb;
  }

//-----------------------------------------------------------
  _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE ${AppConstants.tableName} (${AppConstants.colId} INTEGER NOT NULL  , ${AppConstants.colName} TEXT ,
${AppConstants.colPrice} INTEGER , ${AppConstants.colImg} TEXT , ${AppConstants.colQuantity} INTEGER ,
${AppConstants.colIsExit} INTEGER, ${AppConstants.colTime} TEXT )
'''); //id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT

    print("database is created successfuly ___________________________");
  }
}
