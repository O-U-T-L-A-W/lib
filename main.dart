import 'package:explore/controller/Database/getTwoDayDetails.dart';
import 'package:explore/model/dataFromDB.dart';
import 'package:explore/widgets/activityDistinct.dart';
import 'package:explore/widgets/drawer/currentDaySummary.dart';
import 'package:explore/widgets/homePageWidgets/homePageClock.dart';
import 'package:explore/widgets/saveButtonAddActivity.dart';
import 'package:explore/widgets/showActivites.dart';
import 'package:flutter/material.dart';
import 'widgets/activityStopWatch.dart';
import 'widgets/currentActivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore',
      initialRoute: '/',
      routes: {
        '/showActivitiesPage': (context) => ShowActivities(),
        '/CurrentDaySummary': (context) => CurrentDaySummary(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
          title: 'Tabtivity'), //TODO : add first page < home: WidgetName >
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Expanded(
            child: Column(
              children: <Widget>[
                HomePageClock(),
                //Todays Time and date
                //Current working activity
                //Stopwatch for the activity
                //List of activities top 6

                //  CurrentActivityPage(),
                RaisedButton(
                    child: Text("Show Activities"),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/showActivitiesPage')),
                ActivityStopWatch(),
                DistinctActivitiesArea(),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
          //TODO: change icon

          ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("Drawer Header")),
            ListTile(
                title: Text("Today's Summary"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/CurrentDaySummary');
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: Text("Enter Activity name"),
                  titlePadding: EdgeInsets.all(20),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        TextField(
                          controller: _controller,
                          autofocus: true,
                          enabled: true,
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(labelText: "Activity"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlineButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),

//TODO: fix the save button --- reterive info from datbase

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                child: Text("Save"),
                                onPressed: () async {
                                  saveNewActivity(_controller.text);
                                  return Navigator.popAndPushNamed(
                                      context, '/');
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                );
              });
          return null;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
