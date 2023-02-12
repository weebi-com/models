import 'package:models_weebi/src/closings/closing_range.dart';

abstract class ClosingRangeAbstract {
  final ClosingRange closingRange;
  ClosingRangeAbstract(this.closingRange);
}

abstract class ClosingDateAbstract {
  final DateTime closingDate;
  ClosingDateAbstract(this.closingDate);
}
