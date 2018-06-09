import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

@immutable
class Day {
  Day(
    this.year,
    this.month,
    this.day,
  )   : assert(year != null),
        assert(month != null),
        assert(day != null);

  factory Day.fromDateTime(DateTime dateTime) {
    return new Day(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
  }

  final int year;

  final int month;

  final int day;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => hash3(year, month, day);

  DateTime toDateTime() {
    return new DateTime(year, month, day);
  }

  @override
  String toString() {
    return 'Day:$year.$month.$day';
  }
}
