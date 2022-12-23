import 'package:models_weebi/utils.dart';

extension IsInRange on DateTime {
  bool isDateInRange(DateTime startDateRange, DateTime endDateRange) =>
      (isAfter(startDateRange) || isAtSameMomentAs(startDateRange)) &&
      (isBefore(endDateRange) || isAtSameMomentAs(endDateRange));

  bool isDateInDateRange(DateRange dateRange) =>
      (isAfter(dateRange.startDate) || isAtSameMomentAs(dateRange.startDate)) &&
      (isBefore(dateRange.endDate) || isAtSameMomentAs(dateRange.endDate));
}

extension Month on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime nowYearFirstDay() {
    final now = DateTime.now();
    return DateTime(now.year, 1, 1, 0, 0, 0, 0, 000001);
  }

  DateTime nowYearLastDay() {
    final now = DateTime.now();
    return DateTime(now.year, 12, 31, 23, 59, 59, 99, 999);
  }

  DateTime nowMonthFirstDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 01, 0, 0, 0, 0, 000001);
  }

  DateTime nowMonthLastDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month,
        DateTime(now.year, now.month + 1, 0).day, 23, 59, 59, 99, 999);
  }

  DateTime nowPreviousMonthLastDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 1,
        DateTime(now.year, now.month, 0).day, 23, 59, 59, 99, 999);
  }

  DateTime nowPreviousMonthFirstDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 1, 01, 0, 0, 0, 0, 000001);
  }

  // compiler does not like this for some reason
  DateTime get thisMonthFirstDay =>
      DateTime(year, month, 01, 0, 0, 0, 0, 000001);
  // compiler does not like this for some reason
  DateTime get thisMonthLastDay => DateTime(
      year, month, DateTime(year, month + 1, 0).day, 23, 59, 59, 99, 999);

  DateTime get thisDayStart => DateTime(year, month, day, 0, 0, 0, 0, 000001);
  // compiler does not like this for some reason
  DateTime get thisDayEnd => DateTime(year, month, day, 23, 59, 59, 99, 999);
}
