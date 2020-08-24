import 'package:explore/model/activity.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static String dataBaseName = "activity_database.db";
  static String activityTable = "activity_table";
  Future<Database> getDatabase() async {
    return openDatabase(join(await getDatabasesPath(), dataBaseName),
        version: 1, onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE IF NOT EXISTS activity_table (timestamp TEXT PrimaryKey,name TEXT, duration TEXT)");
    });
  }
}

///String timeStamp(convert using Iso) name srting
void addActivityToLocalDatabase(String timeStamp, String name) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  final Database db = await LocalDatabase().getDatabase();
  String spTimeStamp = sp.getString('currentActivityTimeStamp');

  if (spTimeStamp != null) {
    DateTime activityTimeStamp = DateTime.parse(spTimeStamp);
    DateTime newActivityTimeStamp = DateTime.parse(timeStamp);

    Duration difference = newActivityTimeStamp.difference(activityTimeStamp);

    db.update(LocalDatabase.activityTable, {'duration': difference.toString()},
        where: "timestamp=?", whereArgs: [spTimeStamp]);
  }
  db.insert('activity_table', {'timestamp': timeStamp, 'name': name});

  //setting the current activity in shared preference for fast execution with tiemstamp

  sp.setString('currentActivityName', name);
  sp.setString('currentActivityTimeStamp', timeStamp);
  // db.close();
}

///to get list of all the activities in database till date -timestamp,name.
//is present on two pages
Future<List<Activity>> getAllActivityFromLocalDatabase() async {
  //opening database if not open
  Future<Database> database = openDatabase(
      join(await getDatabasesPath(), LocalDatabase.dataBaseName),
      version: 1);
  final Database db = await database;
  final List<Map<String, dynamic>> a = await db.query('activity_table');
  //closing database
  // db.close();
  List<Activity> temp = (List.generate(
      a.length,
      (index) => Activity(
          a[index]['name'], DateTime.parse(a[index]['timestamp']),
          duration: a[index]['duration'] == null
              ? null
              : parseDuration(a[index]['duration']))));
  print(temp);
  return (temp);
}

// add an extra filed which will containg the duration of activity
// i.e the time of last activity which can be calculated by getting difference form
// last shared prefernce timestamp and current time
Duration parseDuration(String s) {
  int hours = 0;
  int minutes = 0;
  int micros;
  List<String> parts = s.split(':');
  if (parts.length > 2) {
    hours = int.parse(parts[parts.length - 3]);
  }
  if (parts.length > 1) {
    minutes = int.parse(parts[parts.length - 2]);
  }
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}
