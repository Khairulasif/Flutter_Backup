import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLdb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialisation();
      return _db;
    } else {
      return _db;
    }
  }

  //-------------------------------------
  Future<Database> initialisation() async {
    String db_path = await getDatabasesPath();
    String path = join(db_path, "Cinema");
    Database mydb = await openDatabase(path, onCreate: _createDB, version: 1);
    return mydb;
  }

  //----------------------------------------------------
  _createDB(Database db, int version) async {
    await db.execute('''
     CREATE TABLE "users" (
     "id" INTEGER PRIMARY KEY AUTOINCREMENT,
     "username" TEXT NOT NULL,
     "password" Text NOT NULL
      )
     ''');
    print("=====================Database created!==================");
  }

  //------------------CRUD-------------------
  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    int rep = await mydb!.rawInsert(sql);
    return rep;
  }

//--------------------lecture ----------------
  Future<List<Map>> getData(String sql) async {
    Database? mydb = await db;
    List<Map> rep = await mydb!.rawQuery(sql);
    return rep;
  }

//--------------------------------------------
//---------------update-------------------------
  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    int reponse = await mydb!.rawUpdate(sql);
    return reponse;
  }

//---------------------delete----------------------
  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    int reponse = await mydb!.rawDelete(sql);
    return reponse;
  }
//-------------------------
}
