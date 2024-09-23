import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  // Construtor com acesso privado
  DB._();

  // Criar uma instância de DB
  static final DB instance = DB._();

  // Instância do SQLite
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'smart_fridge.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onOpen: (db) async {
        await _createTablesIfNotExists(db);
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    await _createTablesIfNotExists(db);
  }

  Future<void> _createTablesIfNotExists(Database db) async {
    await db.execute(_fridgeTable);
    await db.execute(_shoppingListTable);
  }

  String get _fridgeTable => '''
CREATE TABLE IF NOT EXISTS fridge (
  id TEXT PRIMARY KEY,
  name TEXT,
  amount_value REAL,
  amount_unit TEXT,
  valid_until TEXT
);
''';

  String get _shoppingListTable => '''
CREATE TABLE IF NOT EXISTS shopping_list (
  id TEXT PRIMARY KEY,
  name TEXT,
  amount_value REAL,
  amount_unit TEXT
);
''';
}