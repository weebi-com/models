import 'package:models_weebi/src/common/ticket_type.dart';

extension FlowType on List<FinFlow> {
  FinFlow get sell => firstWhere((t) => t.type == '${TicketType.sell}');
  FinFlow get sellCovered =>
      firstWhere((t) => t.type == '${TicketType.sellCovered}');
  FinFlow get sellDeferred =>
      firstWhere((t) => t.type == '${TicketType.sellDeferred}');
  FinFlow get spend => firstWhere((t) => t.type == '${TicketType.spend}');
  FinFlow get spendCovered =>
      firstWhere((t) => t.type == '${TicketType.spendCovered}');
  FinFlow get spendDeferred =>
      firstWhere((t) => t.type == '${TicketType.spendDeferred}');
  FinFlow get wage => firstWhere((t) => t.type == '${TicketType.wage}');
}

class FinFlow {
  final String type;
  num sumTickets;
  num sumClosings;
  FinFlow(this.type, {required this.sumTickets, this.sumClosings = 0});
  num get sumTotal => (sumTickets + sumClosings);

  // s'incrémente à chaque fois...
  static final emptyFinancials = List<FinFlow>.generate(
    TicketType.financialTypes.length,
    (index) => FinFlow(
      TicketType.financialTypes[index].toString(),
      sumTickets: 0,
      sumClosings: 0,
    ),
  );
  static const String balance = 'balance';
  static const String balanceCumulated = 'balanceCumulated';
  static const String cvo = 'cvo';
}
