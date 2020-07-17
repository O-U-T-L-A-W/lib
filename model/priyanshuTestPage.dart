import 'package:flutter/material.dart';

class TestingWidget extends StatefulWidget {
  @override
  _TestingWidgetState createState() => _TestingWidgetState();
}

class _TestingWidgetState extends State<TestingWidget> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
            child: Column(
          children: <Widget>[
            TextFormField(),
            OutlineButton(
              onPressed: null,
              child: Text("Done"),
            )
          ],
        )),
      ),
    );
  }
}
