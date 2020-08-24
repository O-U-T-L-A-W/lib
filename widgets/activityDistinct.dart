import 'package:explore/controller/localDatabase.dart';
import 'package:explore/model/dataFromDB.dart';
import 'package:flutter/material.dart';

class DistinctActivitiesArea extends StatefulWidget {
  @override
  _DistinctActivitiesAreaState createState() => _DistinctActivitiesAreaState();
}

class _DistinctActivitiesAreaState extends State<DistinctActivitiesArea> {
  Future<List<RaisedButton>> generateActivityButtons() async {
    List nameOfActivities = await DataFromDb().getActivitiesName();
    List<RaisedButton> toreturn = [];
    nameOfActivities.forEach((element) {
      toreturn.add(RaisedButton(
        child: Text(element.toString()),
        onLongPress: () => addActivityToLocalDatabase(
            DateTime.now().toIso8601String(), element),
        onPressed: () => null,
      ));
    });
    return toreturn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView(
        children: <Widget>[
          FutureBuilder(
              initialData: [CircularProgressIndicator()],
              future: generateActivityButtons(),
              builder: (context, snap) {
                if (snap == null) {
                  return CircularProgressIndicator();
                }
                return ListBody(
                  children: snap.data,
                );
              }),
        ],
      ),
    );
  }
}
