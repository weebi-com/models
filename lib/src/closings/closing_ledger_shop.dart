import 'dart:convert';

import 'package:models_base/common.dart';
import 'package:models_base/utils.dart' show DateRange, WeebiDates;
import 'package:models_weebi/src/closings/closing_ledger.dart';
import 'package:models_weebi/src/closings/closing_range.dart';

extension FinFlowsClosingLedgerShop on List<ClosingLedgerShop> {
  List<FinFlow> shopCLFinFlows(
      String shopUuid, DateRange dateRange, List<FinFlow> flows) {
    where(
      (c) => c.shopUuid == shopUuid,
    ).forEach((c) {
      if ((c.closingRange.startDate.isAfter(dateRange.startDate) ||
              c.closingRange.startDate.isAtSameMomentAs(dateRange.startDate)) &&
          (c.closingRange.endDate.isBefore(dateRange.endDate) ||
              c.closingRange.startDate.isAtSameMomentAs(dateRange.startDate))) {
        flows.sell.sumClosings += c.sell;
        flows.sellCovered.sumClosings += c.sellCovered;
        flows.sellDeferred.sumClosings += c.sellDeferred;
        flows.spend.sumClosings += c.spend;
        flows.spendCovered.sumClosings += c.spendCovered;
        flows.spendDeferred.sumClosings += c.spendDeferred;
        flows.wage.sumClosings += c.wage;
      }
    });
    return flows;
  }
}

class ClosingLedgerShop extends ClosingLedger {
  bool get isAllZero =>
      sell == 0 &&
      sellCovered == 0 &&
      sellDeferred == 0 &&
      spend == 0 &&
      spendDeferred == 0 &&
      spendCovered == 0 &&
      wage == 0;
  String shopUuid;
  ClosingLedgerShop(ClosingRange closingRange, this.shopUuid,
      {required int sell,
      required int sellCovered,
      required int sellDeferred,
      required int spend,
      required int spendCovered,
      required int spendDeferred,
      required int wage})
      : super(closingRange,
            sell: sell,
            sellCovered: sellCovered,
            sellDeferred: sellDeferred,
            spend: spend,
            spendCovered: spendCovered,
            spendDeferred: spendDeferred,
            wage: wage);

  static final dummyMar2020 = ClosingLedgerShop(
    ClosingRange(
      date: DateTime.now(),
      startDate: WeebiDates.marStart,
      endDate: WeebiDates.marEnd,
    ),
    'pierre_entrepot',
    sell: 0,
    sellCovered: 0,
    sellDeferred: 200,
    spend: 0,
    spendCovered: 0,
    spendDeferred: 0,
    wage: 0,
  );

  @override
  bool operator ==(other) => identical(closingRange, other);
  @override
  int get hashCode => closingRange.hashCode;

  factory ClosingLedgerShop.fromJson(Map<String, dynamic> map) {
    return ClosingLedgerShop(
      ClosingRange.fromMap(map['closingRange'] as Map<String, dynamic>),
      map['shopUuid'] as String,
      sell: map['sell'] as int,
      sellCovered: map['sellCovered'] as int,
      sellDeferred: map['sellDeferred'] as int,
      spend: map['spend'] as int,
      spendCovered: map['spendCovered'] as int,
      spendDeferred: map['spendDeferred'] as int,
      wage: map['wage'] as int,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingRange': closingRange.toMap(),
      'shopUuid': shopUuid,
      'sell': sell,
      'sellCovered': sellCovered,
      'sellDeferred': sellDeferred,
      'spend': spend,
      'spendCovered': spendCovered,
      'spendDeferred': spendDeferred,
      'wage': wage
    };
  }
}
