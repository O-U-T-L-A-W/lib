import 'package:explore/controller/localDatabase.dart';
import 'package:sqflite/sqflite.dart';

Future<List> getTwoDayDetails() async {
  String whereClause = withinTwoDays();
  String tableName = LocalDatabase.activityTable;
  final Database database = await LocalDatabase().getDatabase();

  List a = (await database.rawQuery(
      "SELECT * FROM $tableName WHERE timestamp LIKE ?", [whereClause]));
  print(a);
}

String withinTwoDays() {
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

  String currentday = (year + "-" + month + "-" + day + "%");
  //print(currentday);

  dateTime = dateTime.subtract(Duration(days: 1));
  day = dateTime.day.toString();
  month = dateTime.month.toString();
  year = dateTime.year.toString();

  if (month.length == 1) {
    month = "0" + month;
  }
  if (day.length == 1) {
    day = "0" + day;
  }

  String previousday = (year + "-" + month + "-" + day + "%");
  // print(previousday);

  String query =
      "`timestamp` LIKE $currentday"; //OR `timestamp` LIKE $previousday";
  // print(query);
  return currentday;
}
