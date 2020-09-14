import 'package:explore/controller/localDatabase.dart';
import 'package:explore/model/activity.dart';
import 'package:sqflite/sqflite.dart';

Future<List> getCurrentDayDetails() async {
  String whereClause = todayWhereClause();
  String tableName = LocalDatabase.activityTable;
  final Database database = await LocalDatabase().getDatabase();

  List a = (await database.rawQuery(
      "SELECT * FROM $tableName WHERE timestamp LIKE ?", [whereClause]));
  // print(a);
  var b = toListOfActivities(a);
  return b;
}

String todayWhereClause() {
  DateTime dateTime = DateTime.now();
  String day = dateTime.day.toString();
  String month = dateTime.month.toString();
  String year = dateTime.year.toString();
  if (month.length == 1) {
    month = "0" + month;
  }
  if (day.length == 1) {
    day = "0" + day;
  }

  return (year + "-" + month + "-" + day + "%");
}
