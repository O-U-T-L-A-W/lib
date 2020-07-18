import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:explore/controller/sqlLib.dart';

class SaveButtonAddActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("Save"),
      onPressed: () async {
        //TODO: get activity name from text button and change ti bottom line

        String activityName = "nameofactivity";

        //Getting current time for adding a timestamp for start of this activity
        DateTime now = DateTime.now();

        //setting the current activity in shared preference for fast execution with tiemstamp
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString('currentActivity', activityName);
        sp.setString('currentActivityTimeStamp', now.toIso8601String());

        //Calling function to add the entry to database
        //TODO: change the 'test' to activity name
        SqlLib.addActivityToLocalDatabase(now.toIso8601String(), 'test');
      },
    );
  }
}
