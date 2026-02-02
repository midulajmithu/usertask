import 'package:flutter_application_1/features/Demo/domain/entities/user_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// database_helper.dart

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/item_master.db';
    return await openDatabase(path, version: 1);
  }

  // Create item_master_<storeId>
  Future<void> createUserTable() async {
    final db = await database;

    await db.execute('''
  CREATE TABLE IF NOT EXISTS UserTables (
    user_id INTEGER PRIMARY KEY,
    name TEXT,
    username TEXT,
    email TEXT,
    phone TEXT,
    website TEXT,
    street TEXT,
    suite TEXT,
    city TEXT,
    zipcode TEXT,
    lat TEXT,
    lng TEXT,
    company_name TEXT,
    company_catch_phrase TEXT,
    company_bs TEXT
  )
''');
  }

  Future<void> insertItems(List<UserEntity> items) async {
    final db = await database;
    final batch = db.batch();

    for (final item in items) {
      batch.insert(
        'UserTables',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<List<UserEntity>> getItems() async {
    final db = await database;
    final result = await db.query('UserTables');
    return result.map(UserEntity.fromMap).toList();
  }

  Future<void> deleteUser(int userId) async {
    final db = await database;
    await db.delete('UserTables', where: 'user_id = ?', whereArgs: [userId]);
  }
}
