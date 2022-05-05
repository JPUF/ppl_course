import 'package:intl/intl.dart';

class DateTimeDay extends DateTime {
  DateTimeDay(super.year, super.month, super.day);

  DateTimeDay.fromDateTime(DateTime dateTime)
      : super(dateTime.year, dateTime.month, dateTime.day);

  @override
  String toString() {
    return DateFormat('EEEE').format(this);
  }
}