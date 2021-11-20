import 'package:weebi_models/src/weebi/item_weebi.dart';
import 'package:weebi_models/src/weebi/taxe_weebi.dart';
import 'package:models_base/base.dart';
import 'package:models_base/common.dart';

// Using WeebiAbstract to rename the attributes shopId && contactInfo,
// That were stupidly changed by a young idealistic dev

abstract class TicketWeebiAbstract
    implements TicketAbstract<ItemWeebi, TaxeWeebi> {
  final String oid; // mongo _id
  final String shopId; // shopUuid
  final String contactInfo; // herderId
  @override
  final int id;
  @override
  String get shopUuid => shopId; // shopUuid // shopId
  @override
  final List<ItemWeebi> items;
  @override
  final TaxeWeebi taxe;
  @override
  final double promo;
  @override
  final String comment;
  @override
  final int received;
  @override
  final DateTime date;
  @override
  final PaiementType paiementType;
  @override
  final TicketType ticketType;
  @override
  String get herderId => contactInfo;
  @override
  final String contactPastPurchasingPower;
  @override
  late bool status;
  @override
  final DateTime statusUpdateDate;
  @override
  final DateTime creationDate;
  @override
  late bool isInDash;

  TicketWeebiAbstract({
    required this.id,
    required this.oid,
    required this.shopId,
    required this.items,
    required this.taxe,
    required this.promo,
    required this.comment,
    required this.received,
    required this.date,
    required this.paiementType,
    required this.ticketType,
    required this.contactInfo,
    required this.contactPastPurchasingPower,
    required this.status,
    required this.statusUpdateDate,
    required this.creationDate,
    this.isInDash = true,
  });
}
