class Activity {
  DateTime _timestamp;
  DateTime get time => _timestamp;
  set time(DateTime t) {
    this._timestamp = t;
  }

  String _activityName;
  String get activityName => _activityName;
  set activityName(String name) {
    this._activityName = name;
  }

  Duration _duration;
  Duration get duration => _duration;
  set duration(Duration d) {
    this._duration = d;
  }

  Activity(String activityName, String timestamp, {String duration}) {
    this._timestamp = DateTime.parse(timestamp);
    this._activityName = activityName;
    this._duration = stringToDuration(duration);
  }

  Map<String, dynamic> toMap() {
    return {
      'activityName': this._activityName,
      'timeStamp': this._timestamp,
      'duration': this._duration
    };
  }
}

List<Activity> toListOfActivities(List<Map<String, dynamic>> s) {
  List<Activity> a = [];
  s.forEach((element) {
    a.add(Activity(element['name'], element['timestamp'],
        duration: element['duration']));
  });
  return a;
}

Duration stringToDuration(String string) {
  if (string == null) {
    return null;
  }
  List a = string.split(":");

  int hours = int.parse(a[0]);
  int minutes = int.parse(a[1]);
  double m = double.parse(a[2]);
  int microseconds = (m * 1000000).toInt();

  return (Duration(hours: hours, minutes: minutes, microseconds: microseconds));
}
