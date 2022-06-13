import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReceiptsDB {
  static Database? _db;
  static const int _version = 1;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDB();
      return _db;
    } else {
      return _db;
    }
  }

  initialDB() async {
    String path = await getDatabasesPath();
    String pathWithName = join(path, 'ReceiptsDB.db');
    Database myDatabase = await openDatabase(pathWithName,
        onCreate: _onCreate, version: _version, onUpgrade: _onUpgrade);
    return myDatabase;
  }

  /*
      is called just one time when db is null
   */
  _onCreate(Database db, int version) async {
    String sql = '''
        CREATE TABLE receiptStatus (
          id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
          idCharLocal TEXT NOT NULL,
          idLocal TEXT NOT NULL,
          pathDB TEXT NOT NULL,
          statusSend_WhatsApp INTEGER,
          statusSend_Server INTEGER
        );
    ''';
    await db.execute(sql);
    sql = '''
        CREATE TABLE receipts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idLocal TEXT NOT NULL,
          whoIsTake TEXT NOT NULL,
          amountText TEXT NOT NULL,
          amountNumeric TEXT NOT NULL,
          causeOfPayment TEXT NOT NULL,
          receiptPdfFileName TEXT NOT NULL,
          statusSend_WhatsApp INTEGER,
          date TEXT NOT NULL,
          type INTEGER
        );
        ''';
    await db.execute(sql);
  }

  /*
      is called just when i changed number of version
  */
  _onUpgrade(Database? db, int oldVersion, int newVersion) async {}

  /*
   * select query this way write it
  */
  readData(String sql) async {
    Database? myDatabase = await db;
    List<Map> response = await myDatabase!.rawQuery(sql);
    return response;
  }

  /*
    * if query is success return number of raw added
    * if query is fail return 0
   */
  insertData(String sql,data) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawInsert(sql,data);
    return response;
  }

  /*
    * if query is success return 1
  */
  updateData(String sql,data) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawUpdate(sql,data);
    return response;
  }

  /*
    * if query is success return 1
   */
  deleteData(String sql) async {
    Database? myDatabase = await db;
    int response = await myDatabase!.rawDelete(sql);
    return response;
  }

  deleteDatabaseInMyApp()async{
    String path = await getDatabasesPath();
    String pathWithName = join(path, 'ReceiptsDB.db');
    deleteDatabase(pathWithName);
  }
}
