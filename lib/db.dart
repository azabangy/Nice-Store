import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'data.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE products
        (id INTEGER PRIMARY KEY AUTOINCREMENT,
         title TEXT,
         type TEXT,
         description TEXT,
         image TEXT,
         price DOUBLE,
         total_price DOUBLE,
         amount INTEGER )
        ''');
    batch.execute('''
        CREATE TABLE products 
        (id INTEGER PRIMARY KEY AUTOINCREMENT,
         title TEXT,
         type TEXT,
         description TEXT,
         image TEXT,
         price DOUBLE,
         total_price DOUBLE,
         amount INTEGER )
        ''');
    print('create SQL');

    await batch.commit();
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // await db.execute('ALTER TABLE notes ADD COLUMN amount INTEGER');
    print('upgrade');
  }

  read(String table) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.query(table);
    return response;
  }

  insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int response = await mydb!.insert(table, values);
    return response;
  }

  update(String table, Map<String, Object?> values, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.update(table, values, where: myWhere);
    return response;
  }

  delete(String table, String? myWhere) async {
    Database? mydb = await db;
    int response = await mydb!.delete(table, where: myWhere);
    return response;
  }
}
