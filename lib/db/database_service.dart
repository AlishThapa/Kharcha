import 'package:kharcha_book/models/kharcha.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'db_model/database_model.dart';

class DatabaseService {
  Future<Database> connectDb() async {
    var database = await openDatabase(join(await getDatabasesPath(), 'kharcha.db'), version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE dbTableKharcha(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, amount INTEGER, date TEXT )');
    }, onConfigure: onConfigure);
    return database;
  }

  onConfigure(Database db) async {
    await db.execute("PRAGMA foreign_keys = ON");
  }

  create(DatabaseModel databaseModel) async {
    final db = await DatabaseService().connectDb();
    await db.insert('dbTableKharcha', databaseModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<KharchaTransaction>> readKharcha() async {
    final db = await DatabaseService().connectDb();
    var dbRead = await db.query('dbTableKharcha');
    return List.generate(
      dbRead.length,
      (index) {
        // String iso8601String = dbRead[index]['date'] as String;
        // DateTime dateTime = DateTime.parse(iso8601String);
        return KharchaTransaction(
          id:dbRead[index]['id']as int,
          title: dbRead[index]['title'] as String,
          amount: dbRead[index]['amount'] as int,
          // date: (dbRead[index]['date'] as String),
          // date: dateTime,
          // dateId: dbRead[index]['dateId'] as String,
        );
      },
    );
  }

  delete(int id) async {
    final db = await DatabaseService().connectDb();
    await db.delete(
      'dbTableKharcha',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
