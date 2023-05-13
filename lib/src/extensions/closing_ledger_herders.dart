import 'package:models_weebi/closings.dart';

extension ClosingHerderLastBalance on Iterable<ClosingLedgerHerder> {
  int closingHerderLastBalance(int herderId) {
    if (this == null || isEmpty) {
      return 0;
    } else {
      final filtered = where((element) => element.herderId == '$herderId')
          .toList()
        ..sort((a, b) =>
            a.closingRange.startDate.compareTo(b.closingRange.startDate));
      if (filtered.isEmpty) {
        return 0;
      } else {
        return filtered.last.balance;
      }
    }
  }
}
