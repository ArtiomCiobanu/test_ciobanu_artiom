import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_ciobanu_artiom/Models/ProductDBNote.dart';

class DatabaseTools {
  static String dbName = "test_db.db";
  static String dbPath;

  static String tableName = "productDBNotes";
  static String tablePath;

  static Database _database;
  static Future<Database> get database async {
    if (_database == null) {
      _database = await createDatabase();
    }

    return _database;
  }

  static Future<void> deleteTable() async {
    dbPath = await getDatabasesPath() + "/$dbName";
    tablePath = "$dbPath/$tableName";

    var db = await openDatabase(tablePath);

    await db.delete(tablePath);
  }

  static Future<Database> createDatabase() async {
    dbPath = join(await getDatabasesPath(), dbName);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
            "CREATE TABLE $tableName(id INTEGER PRIMARY KEY, isFavorite BIT, isAddedToCart BIT)");
      },
    );
  }

  static Future<int> insertProductDBNote(ProductDBNote note) async {
    var db = await database;

    var res = await db.insert(tableName, note.toMap());

    return res;
  }

  static Future<int> updateProductDBNote(ProductDBNote note) async {
    final db = await database;

    var res = db.update(tableName, note.toMap());

    return res;
  }

  static Future<List<ProductDBNote>> getProductDBNotes() async {
    final db = await database;

    final data = await db.query(tableName);

    return List.generate(
      data.length,
      (index) => ProductDBNote(
        data[index]['id'],
        data[index]['isFavorite'] == 0 ? false : true,
        data[index]['isAddedToCart'] == 0 ? false : true,
      ),
    );
  }
}
