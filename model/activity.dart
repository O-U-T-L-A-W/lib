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
}
