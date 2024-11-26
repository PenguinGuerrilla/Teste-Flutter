import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    String path = join(await getDatabasesPath(), 'meu_banco.db');
    return await openDatabase(path,
        version: 2, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    create table user (
    username text primary key,
    password text
    )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute("alter table user add column ultimo_login text");
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
