import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityStopWatch extends StatefulWidget {
  @override
  _ActivityStopWatchState createState() => _ActivityStopWatchState();
}

class _ActivityStopWatchState extends State<ActivityStopWatch> {
  Stream<String> getLatestActivityStartTime() async* {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    for (int i = 0; i < 2;) {
      DateTime temp = DateTime.parse(sp.getString("currentActivityTimeStamp"));
      Duration a = DateTime.now().difference(temp);
      await Future.delayed(Duration(seconds: 1));
      yield a.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.pink,
      child: Column(
        children: [
          StreamBuilder(
            initialData: Text("0"),
            stream: getLatestActivityStartTime(),
            builder: (context, snapshot) {
              return (Text(snapshot.data.toString()));
            },
          ),
        ],
      ),
    );
  }
}
