import 'dart:convert';

import 'package:models_base/common.dart' show FinancialSums;
import 'package:meta/meta.dart';
import 'package:models_weebi/src/closings/abstract/closing_range.dart';
import 'package:models_weebi/src/closings/closing_range.dart';

class ClosingLedger implements ClosingRangeAbstract, FinancialSums {
  @override
  final ClosingRange closingRange;
  @override
  int sell;
  @override
  int sellCovered;
  @override
  int sellDeferred;
  @override
  int spend;
  @override
  int spendCovered;
  @override
  int spendDeferred;
  @override
  int wage;

  ClosingLedger(this.closingRange,
      {required this.sell,
      required this.sellCovered,
      required this.sellDeferred,
      required this.spend,
      required this.spendCovered,
      required this.spendDeferred,
      required this.wage});

  static final dummyFeb = ClosingLedger(ClosingRange.dummyLastMonth,
      sell: 20,
      sellCovered: 0,
      sellDeferred: 0,
      spend: 0,
      spendCovered: 0,
      spendDeferred: 0,
      wage: 0);

  @override
  bool operator ==(other) => identical(closingRange, other);

  @override
  int get hashCode => closingRange.hashCode;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'closingRange': closingRange.toMap(),
      'sell': sell,
      'sellCovered': sellCovered,
      'sellDeferred': sellDeferred,
      'spend': spend,
      'spendCovered': spendCovered,
      'spendDeferred': spendDeferred,
      'wage': wage
    };
  }

  factory ClosingLedger.fromMap(Map<String, dynamic> map) {
    return ClosingLedger(
      ClosingRange.fromMap(map['closingRange'] as Map<String, dynamic>),
      sell: map['sell'] as int,
      sellCovered: map['sellCovered'] as int,
      sellDeferred: map['sellDeferred'] as int,
      spend: map['spend'] as int,
      spendCovered: map['spendCovered'] as int,
      spendDeferred: map['spendDeferred'] as int,
      wage: map['wage'] as int,
    );
  }
}
