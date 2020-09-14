import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityStopWatch extends StatefulWidget {
  @override
  _ActivityStopWatchState createState() => _ActivityStopWatchState();
}

class _ActivityStopWatchState extends State<ActivityStopWatch> {
  Stream<List<String>> getLatestActivityStartTime() async* {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    for (int i = 0; i < 2;) {
      DateTime temp = DateTime.parse(sp.getString("currentActivityTimeStamp"));

      Duration a = DateTime.now().difference(temp);

      String hours = (a.inHours % 24).toString();

      String minutes = (a.inMinutes % 60) < 10
          ? "0" + (a.inMinutes % 60).toString()
          : (a.inMinutes % 60).toString();

      String seconds = (a.inSeconds % 60) < 10
          ? "0" + (a.inSeconds % 60).toString()
          : (a.inSeconds % 60).toString();

      yield [
        sp.getString("currentActivityName"),
        hours + " hr " + minutes + " min " + seconds + " sec "
      ];

      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              initialData: Text("0"),
              stream: getLatestActivityStartTime(),
              builder: (context, snapshot) {
                String duration = snapshot.data[1];
                String name = snapshot.data[0];

                return Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          color: Colors.black26,
                        ),
                        flex: 1,
                      ),
                      Expanded(
                        child: Text(duration),
                        flex: 2,
                      )
                    ],
                  ),
                );
                return (Text(name + " \t\tfor " + duration));
              },
            ),
          ),
        ],
      ),
    );
  }
}
