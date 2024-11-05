import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:wirdul_latif/model/wird_history_item.dart';

class WirdDatabaseHelper {
  static final WirdDatabaseHelper _instance = WirdDatabaseHelper._internal();
  static Database? _database;

  factory WirdDatabaseHelper() {
    return _instance;
  }

  WirdDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'wird_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE wird(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            createdDate TEXT,
            currentWird INTEGER,
            status TEXT,
            wirdType TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  // Insert a new
  Future<int> insertWird(WirdHistroyItem wird) async {
    final db = await database;
    return await db.insert('wird', wird.toMap());
  }

  // Retrieve all
  Future<List<WirdHistroyItem>> getWirds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wird');
    return List.generate(maps.length, (i) {
      return WirdHistroyItem.fromMap(maps[i]);
    });
  }

  void printWirds() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('wird');
    List<WirdHistroyItem> wirds = List.generate(maps.length, (i) {
      return WirdHistroyItem.fromMap(maps[i]);
    });
    // print in table format
    print('----------------');
    for (var wird in wirds) {
      print(
          '${wird.id}\t${wird.createdDate}\t${wird.currentWird}\t${wird.status}');
    }
    print('----------------');

  }

  // Update a
  Future<int> updateWird(WirdHistroyItem wird) async {
    final db = await database;
    return await db.update(
      'wird',
      wird.toMap(),
      where: 'id = ?',
      whereArgs: [wird.id],
    );
  }

  // Delete a
  Future<void> deleteWird(int id) async {
    final db = await database;
    await db.delete(
      'wird',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
