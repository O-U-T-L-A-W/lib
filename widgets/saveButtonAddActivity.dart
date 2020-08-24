import 'package:shared_preferences/shared_preferences.dart';
import 'package:explore/controller/localDatabase.dart';

void saveNewActivity(String activityName) async {
  //Getting current time for adding a timestamp for start of this activity
  DateTime now = DateTime.now();

  //Calling function to add the entry to database
  addActivityToLocalDatabase((now.toIso8601String()), activityName);
}
