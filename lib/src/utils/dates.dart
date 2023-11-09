abstract class WeebiDates {
  static final febStart = DateTime(2020, 2, 1, 0, 0, 0, 0, 000001);
  static final febEnd = DateTime(2020, 2, 29, 23, 59, 59, 99, 999);
  static final marStart = DateTime(2020, 3, 1, 0, 0, 0, 0, 000001);
  static final marEnd = DateTime(2020, 3, 31, 23, 59, 59, 99, 999);
  static final octStart = DateTime(2021, 10, 1, 0, 0, 0, 0, 000001);
  static final octEnd = DateTime(2021, 10, 31, 23, 59, 59, 99, 999);
  static final defaultFirstDate = DateTime(2020, 02, 02, 0, 0, 0, 0, 000001);
  static final defaultLastDate = DateTime(3030, 03, 03, 23, 59, 59, 99, 999);
  static final defaultDate =
      DateTime(2020, 02, 02); // DO NOT be tempted to change this, used in mongo
}

extension Month on DateTime {
  DateTime thisMonthFirstDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, 01, 0, 0, 0, 0, 000001);
  }

  DateTime thisMonthLastDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month,
        DateTime(now.year, now.month + 1, 0).day, 23, 59, 59, 99, 999);
  }

  DateTime previousMonthLastDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 1,
        DateTime(now.year, now.month, 0).day, 23, 59, 59, 99, 999);
  }

  DateTime previousMonthFirstDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month - 1, 01, 0, 0, 0, 0, 000001);
  }
}

extension Day on DateTime {
  DateTime thisDayFirstSecond() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 000001);
  }

  DateTime thisDayLastSecond() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59, 99, 999);
  }
}
