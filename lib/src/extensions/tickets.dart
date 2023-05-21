import 'package:models_weebi/utils.dart';
import 'package:models_weebi/weebi_models.dart';

extension TicketsFilters on Iterable<TicketWeebi> {
  TwoLists<TicketWeebi> filterById({required List<TicketWeebi>? newList}) {
    final noDups = <TicketWeebi>[];
    final dups = <TicketWeebi>[];
    newList ??= <TicketWeebi>[];
    if (isEmpty) {
      return TwoLists(dups: <TicketWeebi>[], noDups: newList);
    }
    final oldListIds = map((e) => e.id);
    final newListIds = map((e) => e.id);
    for (final newId in newListIds) {
      if (oldListIds.contains(newId)) {
        dups.add(newList.firstWhere((e) => e.id == newId));
      } else {
        noDups.add(newList.firstWhere((e) => e.id == newId));
      }
    }
    return TwoLists(dups: dups, noDups: noDups);
  }
}
