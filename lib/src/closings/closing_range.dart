import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:models_base/utils.dart';

class ClosingRange implements DateRange {
  final DateTime date;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  const ClosingRange(
      {required this.date, required this.startDate, required this.endDate});

  bool isInRange(DateTime startDateRange, DateTime endDateRange) {
    return (startDate.isAfter(startDateRange) ||
            startDate.isAtSameMomentAs(startDateRange)) &&
        (endDate.isBefore(endDateRange) ||
            endDate.isAtSameMomentAs(endDateRange));
  }

  static final ClosingRange dummyLastMonth = ClosingRange(
    date: DateTime.now(),
    startDate: DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
      1,
    ),
    endDate: DateTime(0).previousMonthLastDay(),
  );
  static final dummyFeb = ClosingRange(
    date: WeebiDates.febEnd,
    startDate: WeebiDates.febStart,
    endDate: WeebiDates.febEnd,
  );

  static final dummyMar = ClosingRange(
    date: DateTime.now(),
    startDate: WeebiDates.marStart,
    endDate: WeebiDates.marEnd,
  );

  static final dummyNov20ToJuly21 = ClosingRange(
    date: DateTime.now(),
    startDate: DateTime(2020, 11, 31, 23, 59, 59),
    endDate: DateTime(2021, 7, 31, 23, 59, 59),
  );

  static final dummyJuly21ToOct21 = ClosingRange(
    date: DateTime.now(),
    startDate: DateTime(2021, 7, 31, 23, 59, 59),
    endDate: DateTime(2021, 10, 31, 23, 59, 59),
  );

  Map<String, dynamic> toMap() {
    if (date == null || startDate == null || endDate == null) {
      print('toMap no date can be null in a closingRange');
      return {};
    } else {
      return {
        'date': date.toIso8601String(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      };
    }
  }

  factory ClosingRange.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      print('fromMap no date can be null in a closingRange');
      return ClosingRange.dummyFeb;
    } else {
      return ClosingRange(
        date: DateTime.parse(map['date']),
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']),
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory ClosingRange.fromJson(String source) =>
      ClosingRange.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClosingRange &&
        other.date == date &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return date.hashCode ^ startDate.hashCode ^ endDate.hashCode;
  }
}
