import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentActivityPage extends StatefulWidget {
  @override
  _CurrentActivityPageState createState() => _CurrentActivityPageState();
}

class _CurrentActivityPageState extends State<CurrentActivityPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: fix this stream or find another way
    Stream shpr = SharedPreferences.getInstance().asStream();
    setState(() {
      int i = 0;
      i++;
    });
    return Container(
      child: StreamBuilder(
          stream: shpr,
          builder: (context, sp) {
            return Text(sp.data.getString('currentActivity'));
          }),
    );
  }
}
