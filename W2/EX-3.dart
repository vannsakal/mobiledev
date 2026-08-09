class MyDuration {
  final int _milliseconds;

  MyDuration._internal(this._milliseconds) {
    if (_milliseconds < 0) {
      throw ArgumentError('Duration shall always be greater or equal to 0');
    }
  }

  MyDuration.fromHours(int hours) : this._internal(hours * 60 * 60 * 1000);

  MyDuration.fromMinutes(int minutes) : this._internal(minutes * 60 * 1000);

  MyDuration.fromSeconds(int seconds) : this._internal(seconds * 1000);

  int get inMilliseconds => _milliseconds;

  bool operator >(MyDuration other) {
    return this._milliseconds > other._milliseconds;
  }

  MyDuration operator +(MyDuration other) {
    return MyDuration._internal(this._milliseconds + other._milliseconds);
  }

  MyDuration operator -(MyDuration other) {
    int result = this._milliseconds - other._milliseconds;
    if (result < 0) {
      throw Exception('Resulting duration cannot be negative!');
    }
    return MyDuration._internal(result);
  }

  @override
  String toString() {
    int seconds = (_milliseconds / 1000).round();
    int minutes = (seconds / 60).floor();
    seconds = seconds % 60;
    int hours = (minutes / 60).floor();
    minutes = minutes % 60;
    return '$hours hours, $minutes minutes, $seconds seconds';
  }
}

void main() {
  MyDuration duration1 = MyDuration.fromHours(3);
  MyDuration duration2 = MyDuration.fromMinutes(45);

  print(duration1 + duration2);
  print(duration1 > duration2);

  try {
    print(duration2 - duration1);
  } catch (e) {
    print(e);
  }
}
