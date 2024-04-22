import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Banco {
  static final Banco instance = Banco._();
  static Database? _database;

  Banco._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'store.db');
    return await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        name TEXT,
        price REAL,
        quantity REAL DEFAULT 0
      )''');
  }

  static Future<void> deleteDatabaseIfExists() async {
    final databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'store.db');
    bool exists = await databaseExists(path);
    if (exists) {
      // If the database exists, delete it
      await deleteDatabase(path);
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
