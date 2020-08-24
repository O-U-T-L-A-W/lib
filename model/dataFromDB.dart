import 'package:sqflite/sqflite.dart';
import 'package:explore/controller/localDatabase.dart';

class DataFromDb {
  ///Sends List the name of unique Activity names present in Database.
  Future<List<dynamic>> getActivitiesName() async {
    List<dynamic> result = [];

    Database _db = await LocalDatabase().getDatabase();
    await _db.query(LocalDatabase.activityTable,
        distinct: true, columns: ['name']).then((value) {
      value.forEach((element) {
        result.add(element.values.first);
      });
    });
    return result;
  }
}
