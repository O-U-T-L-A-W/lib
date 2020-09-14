import 'package:explore/controller/Database/getCurrentDayDetails.dart';
import 'package:explore/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CurrentDaySummary extends StatefulWidget {
  @override
  _CurrentDaySummaryState createState() => _CurrentDaySummaryState();
}

class _CurrentDaySummaryState extends State<CurrentDaySummary> {
  @override
  Widget build(BuildContext context) {
    Map sumOfDuration = {};

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blue[100],
          child: FutureBuilder(
              future: getCurrentDayDetails(),
              builder: (context, snapdata) {
                switch (snapdata.connectionState) {
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    break;
                  case ConnectionState.waiting:
                    return LinearProgressIndicator();
                    break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    break;
                  case ConnectionState.done:
                    List<Card> toreturn = [];
                    List<Activity> data = snapdata.data;
                    data.forEach((element) {
                      if (element.duration != null) {
                        sumOfDuration.containsKey(element.activityName)
                            ? sumOfDuration[element.activityName] +=
                                element.duration
                            : sumOfDuration[element.activityName] =
                                element.duration;
                      }
                    });
                    int oneDayDuration = Duration(days: 1).inMilliseconds;
                    sumOfDuration.forEach((key, value) {
                      var percentage =
                          ((value.inMilliseconds) / oneDayDuration).toString();
                      toreturn.add(Card(
                          child: Container(
                              child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularPercentIndicator(
                              radius: 60,
                              percent: double.parse(percentage),
                              center: Text((double.parse(percentage) * 100)
                                      .toStringAsFixed(1) +
                                  "%"),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(key),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(readableDuration(value)),
                            ),
                          ],
                        ),
                      ))));
                    });
                    //print(sumOfDuration);

                    return Column(
                      children: toreturn,
                    );

                    break;
                }
              }),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context)),
      ),
    );
  }

  String readableDuration(Duration duration) {
    String hour = ((duration.inHours) % 24).toString();
    hour = hour != '0' ? hour + "h " : "";
    String minutes = ((duration.inMinutes) % 60).toString();
    minutes = minutes != '0' ? minutes + "m " : "";
    return (hour + minutes);
  }
}
