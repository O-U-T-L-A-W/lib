import 'package:explore/controller/localDatabase.dart';
import 'package:explore/model/activity.dart';
import 'package:flutter/material.dart';

class ShowActivities extends StatefulWidget {
  @override
  _ShowActivitiesState createState() => _ShowActivitiesState();
}

class _ShowActivitiesState extends State<ShowActivities> {
  @override
  Widget build(BuildContext context) {
    Future<List<Activity>> a = getAllActivityFromLocalDatabase();
    return Scaffold(
      body: ListView(children: <Widget>[
        StreamBuilder(
          stream: a.asStream(),
          // ignore: missing_return
          builder: (context, snap) {
            switch (snap.connectionState) {
              case ConnectionState.none:
                return LinearProgressIndicator();
                break;
              case ConnectionState.waiting:
                return LinearProgressIndicator();
                break;
              case ConnectionState.active:
                return LinearProgressIndicator();
                break;
              case ConnectionState.done:
                List<Activity> temp = snap.data;
                List<ListTile> toreturn;
                toreturn == null ? toreturn = [] : toreturn.clear();
                temp.forEach((element) {
                  toreturn.add(
                    ListTile(
                      title: Text(element.activityName),
                      subtitle: Text(element.time.toIso8601String()),
                      trailing: Text(element.duration.toString()),
                    ),
                  );
                });

                return Column(children: toreturn);

                break;
            }
          },
        ),
      ]),
    );
  }
}
