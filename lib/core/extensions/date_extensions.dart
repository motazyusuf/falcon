extension DateTimeFormatExtension on DateTime {
  String get toDateOnlyString {
    return toString().substring(0, 10);
  }
}

extension DateOnlyExtension on DateTime {
  DateTime get dateOnly {
    return DateTime(year, month, day);
  }
}
