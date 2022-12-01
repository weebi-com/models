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
    return DateTime(now.year, 1, 31, 0, 0, 0, 0, 000001);
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

  DateTime thisMonthFirstDay(DateTime date) =>
      DateTime(date.year, date.month, 01, 0, 0, 0, 0, 000001);

  DateTime thisMonthLastDay(DateTime date) => DateTime(date.year, date.month,
      DateTime(date.year, date.month + 1, 0).day, 23, 59, 59, 99, 999);
}
