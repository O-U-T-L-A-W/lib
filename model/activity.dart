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

  Activity(String activityName, DateTime timestamp, {Duration duration}) {
    this._timestamp = timestamp;
    this._activityName = activityName;
    this._duration = duration;
  }

  Map<String, dynamic> toMap() {
    return {
      'activityName': this._activityName,
      'timeStamp': this._timestamp,
      'duration': this._duration
    };
  }
}
