import 'dart:convert';

import 'package:models_base/common.dart';
import 'package:models_base/utils.dart' show DateRange, WeebiDates;
import 'package:models_weebi/src/closings/abstract/closing_herder.dart';

import 'package:models_weebi/src/closings/closing_ledger.dart';
import 'package:models_weebi/src/closings/closing_range.dart';

extension FinFlowsClosingLedgerHerder on List<ClosingLedgerHerder> {
  List<FinFlow> herderClFinFlows(
      String herderId, DateRange dateRange, List<FinFlow> flows) {
    //print('function dateRange start ${dateRange.startDate}');
    //print('function dateRange endDate ${dateRange.endDate}');
    //print('first c startDate ${first.closingRange.startDate}');
    //print('first c endDate ${first.closingRange.endDate}');
    //print('last c startDate ${last.closingRange.startDate}');
    //print('last c endDate ${last.closingRange.endDate}');
    forEach((c) {
      if (c.herderId == herderId) {
        if ((c.closingRange.startDate.isAtSameMomentAs(dateRange.startDate) ||
                c.closingRange.startDate.isAfter(dateRange.startDate)) &&
            (c.closingRange.endDate.isAtSameMomentAs(dateRange.endDate) ||
                c.closingRange.endDate.isBefore(dateRange.endDate))) {
          flows.sell.sumClosings += c.sell;
          flows.sellCovered.sumClosings += c.sellCovered;
          flows.sellDeferred.sumClosings += c.sellDeferred;
          flows.spend.sumClosings += c.spend;
          flows.spendCovered.sumClosings += c.spendCovered;
          flows.spendDeferred.sumClosings += c.spendDeferred;
          flows.wage.sumClosings += c.wage;
        }
      }
    });
    return flows;
  }
}

class ClosingLedgerHerder extends ClosingLedger
    implements ClosingHerderAbstract {
  @override
  String herderId;
  int balance;
  bool get isAllZero =>
      sell == 0 &&
      sellCovered == 0 &&
      sellDeferred == 0 &&
      spend == 0 &&
      spendDeferred == 0 &&
      spendCovered == 0 &&
      wage == 0;

  ClosingLedgerHerder(
    ClosingRange closingRange, {
    required this.herderId,
    // le solde à l'instant t, avec l'ancien solde, et non pas juste le solde du mois
    // balance = previous balance + solde client - solde fournisseur - solde wages
    required this.balance,
    required int sell,
    required int sellCovered,
    required int sellDeferred,
    required int spend,
    required int spendCovered,
    required int spendDeferred,
    required int wage,
  }) : super(
          closingRange,
          sell: sell,
          sellCovered: sellCovered,
          sellDeferred: sellDeferred,
          spend: spend,
          spendCovered: spendCovered,
          spendDeferred: spendDeferred,
          wage: wage,
        );

  static final dummyFeb = ClosingLedgerHerder(
    ClosingRange.dummyFeb,
    herderId: '1',
    sell: 0,
    sellCovered: 0,
    sellDeferred: 40,
    spend: 0,
    spendCovered: 0,
    spendDeferred: 20,
    wage: 0,
    balance: -20,
  );
  static final dummyMar2020 = ClosingLedgerHerder(
    ClosingRange(
      date: DateTime.now(),
      startDate: WeebiDates.marStart,
      endDate: WeebiDates.marEnd,
    ),
    herderId: '1',
    sell: 0,
    sellCovered: 0,
    sellDeferred: 40,
    spend: 0,
    spendCovered: 0,
    spendDeferred: 20,
    wage: 0,
    balance: -20,
  );

  @override
  bool operator ==(other) => identical(closingRange, other);

  @override
  int get hashCode => closingRange.hashCode;

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'closingRange': closingRange.toMap(),
      'herderId': herderId ?? '0',
      'sell': sell,
      'balance': balance ?? 0,
      'sellCovered': sellCovered,
      'sellDeferred': sellDeferred,
      'spend': spend,
      'spendCovered': spendCovered,
      'spendDeferred': spendDeferred,
      'wage': wage
    };
  }

  factory ClosingLedgerHerder.fromMap(Map<String, dynamic> map) {
    return ClosingLedgerHerder(
      // ignore: missing_required_param
      ClosingRange.fromMap(map['closingRange']),
      herderId: map['herderId'],
      balance: map['balance'] ?? 0,
      sell: map['sell'],
      sellCovered: map['sellCovered'],
      sellDeferred: map['sellDeferred'],
      spend: map['spend'],
      spendCovered: map['spendCovered'],
      spendDeferred: map['spendDeferred'],
      wage: map['wage'],
    );
  }
}
