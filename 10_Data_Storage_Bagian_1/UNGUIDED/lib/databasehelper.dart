import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ppbsqlite.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mahasiswa (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama TEXT,
        nim TEXT,
        alamat TEXT,
        hobi TEXT
      )
    ''');
  }

  // CREATE
  Future<int> create(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('mahasiswa', data);
  }

  // READ
  Future<List<Map<String, dynamic>>> read() async {
    final db = await database;
    return await db.query('mahasiswa');
  }
}
