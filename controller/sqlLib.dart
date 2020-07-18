import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLib {
  static void addActivityToLocalDatabase(String timeStamp, String name) async {
    final Future<Database> database = openDatabase(
        join(await getDatabasesPath(), 'activity_database.db'),
        version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE IF NOT EXISTS activity_table (timestamp TEXT PrimaryKey,name TEXT)");
    });
    final Database db = await database;
    db.insert('activity_table', {'timestamp': timeStamp, 'name': name});

    final List<Map<String, dynamic>> a = await db.query(
      'activity_table',
    );
    print(a.length);
    print(a.toString());
  }
}
