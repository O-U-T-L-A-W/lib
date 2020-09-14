import 'dart:async';

import 'package:flutter/material.dart';

class HomePageClock extends StatefulWidget {
  @override
  _HomePageClockState createState() => _HomePageClockState();
}

class _HomePageClockState extends State<HomePageClock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Row(children: timeOfDayWidgets(DateTime.now()))],
      ),
    );
  }
}

List<Widget> timeOfDayWidgets(DateTime dateTime) {
  TextStyle timeOnHomePageTextStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 26);
  }

  return [
    Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateTime.now().hour < 10
                        ? "0" + dateTime.hour.toString()
                        : DateTime.now().hour.toString(),
                    style: timeOnHomePageTextStyle(),
                  ),
                ),
                Text(":"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    DateTime.now().minute < 10
                        ? "0" + dateTime.minute.toString()
                        : DateTime.now().minute.toString(),
                    style: timeOnHomePageTextStyle(),
                  ),
                ),
              ],
            ),
            Card(child: Text(DateTime.now().toIso8601String()))
          ],
        ),
      ),
    ),
  ];
}
