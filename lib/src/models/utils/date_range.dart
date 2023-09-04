import 'package:meta/meta.dart';
import 'package:models_weebi/utils.dart';

@immutable
class DateRangeW extends DateRange {
  final DateTime start;
  final DateTime end;

  DateRangeW({required this.start, required this.end})
      : assert(!start.isAfter(end)),
        super(start, end);

  Duration get duration => end.difference(start);

  static final defaultDateRange = DateRangeW(
      start: WeebiDates.defaultFirstDate, end: WeebiDates.defaultLastDate);

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DateRangeW && other.start == start && other.end == end;
  }

  @override
  int get hashCode => Object.hash(start, end);

  @override
  String toString() => '$start - $end';
}
