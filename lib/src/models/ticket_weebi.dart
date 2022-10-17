// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/ticket_mixin_weebi_base.dart';
import 'package:models_weebi/src/models/ticket_mixin_weebi_print.dart';
import 'package:models_base/common.dart';
import 'package:collection/collection.dart';
import 'package:models_weebi/weebi_models.dart';

// getters are in the mixin => much lighter
// hence TicketWeebiAbstract + avoiding any confusion with Item and ArticleBasket
class TicketWeebi extends TicketWeebiAbstract
    with TicketPrinter, TicketMixinWeebiBase {
  TicketWeebi({
    required final String oid,
    required final int id,
    required final String shopId, // shopUuid
    required final List<ItemCartWeebi> items,
    required final TaxeWeebi taxe,
    required final double promo,
    required final String comment,
    required final int received,
    required final DateTime date,
    required final PaiementType paiementType,
    required final TicketType ticketType,
    required final String contactInfo, // herderId
    required final String contactPastPurchasingPower,
    required final bool status,
    required DateTime? statusUpdateDate,
    required final DateTime creationDate,
  }) : super(
          id: id,
          oid: oid,
          shopId: shopId,
          items: items,
          taxe: taxe,
          promo: promo,
          comment: comment,
          received: received,
          date: date,
          paiementType: paiementType,
          ticketType: ticketType,
          contactInfo: contactInfo,
          contactPastPurchasingPower: contactPastPurchasingPower,
          status: status,
          statusUpdateDate: statusUpdateDate ?? WeebiDates.defaultDate,
          creationDate: creationDate,
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TicketWeebi &&
        other.id == id &&
        other.shopUuid == shopUuid &&
        listEquals(other.items, items) &&
        other.taxe == taxe &&
        other.promo == promo &&
        other.comment == comment &&
        other.received == received &&
        other.date == date &&
        other.paiementType == paiementType &&
        other.ticketType == ticketType &&
        other.herderId == herderId &&
        other.status == status &&
        other.statusUpdateDate == statusUpdateDate &&
        other.creationDate == creationDate;
  }

  @override
  String toString() => """
TicketWeebi{
      'id': $id,
      'shopUuid': $shopUuid,
      'items': ${items.map((x) => x.toMap()).toList()},
      'taxe': ${taxe.toMap()},
      'promo': $promo,
      'comment': $comment,
      'contactPastPurchasingPower': $contactPastPurchasingPower,
      'received': $received,
      'date': ${date.toIso8601String()},
      'paiementType': $paiementType,
      'ticketType': $ticketType,
      'herderId': $herderId,
      'status': $status,
      'statusUpdateDate': ${statusUpdateDate.toIso8601String()},
      'creationDate': ${creationDate.toIso8601String()},
      'isInDash': $isInDash,
    };
  }
  """;

  @override
  int get hashCode {
    return id.hashCode ^
        shopUuid.hashCode ^
        items.hashCode ^
        taxe.hashCode ^
        promo.hashCode ^
        comment.hashCode ^
        received.hashCode ^
        date.hashCode ^
        paiementType.hashCode ^
        ticketType.hashCode ^
        herderId.hashCode ^
        statusUpdateDate.hashCode ^
        creationDate.hashCode;
  }

  static final dummySell = TicketWeebi(
    oid: 'oid',
    id: 1,
    shopId: 'shopId',
    items: [ItemCartWeebi.dummy],
    taxe: TaxeWeebi.noTax,
    promo: 0.0,
    comment: 'comment',
    received: 0,
    date: WeebiDates.defaultDate,
    paiementType: PaiementType.cash,
    ticketType: TicketType.sell,
    contactInfo: 'contactInfo',
    contactPastPurchasingPower: 'contactPastPurchasingPower',
    status: true,
    statusUpdateDate: WeebiDates.defaultDate,
    creationDate: WeebiDates.defaultDate,
  );

  //@override
  //set statusUpdateDate(DateTime? _statusUpdateDate) {
  //  statusUpdateDate = _statusUpdateDate ?? WeebiDates.defaultDate;
  //}

  factory TicketWeebi.fromJson(String source) =>
      TicketWeebi.fromMap(json.decode(source));

  factory TicketWeebi.fromMap(Map<String, dynamic> map) {
    return TicketWeebi(
      id: map['id'] as int,
      oid: map['oid'] as String,
      shopId: map['shopId'] as String,
      items: List<ItemCartWeebi>.from(
          map['items']?.map((x) => ItemCartWeebi.fromMap(x))),
      taxe: TaxeWeebi.fromMap(map['taxe']),
      promo: map['promo'] == null ? 0.0 : (map['promo'] as num).toDouble(),
      comment: map['comment'],
      contactPastPurchasingPower: map['contactPastPurchasingPower'] as String,
      received: map['received'] as int,
      date: DateTime.tryParse(map['date']) ?? WeebiDates.defaultDate,
      paiementType: (map['paiementType'] is String)
          ? PaiementType.tryParse(map['paiementType'] as String)
          : PaiementType.tryParse(map['paiementType']['paiementType']),
      ticketType:
          TicketType.tryParse(map['ticketType'] as String), // removed as String
      contactInfo: map['contactInfo'] as String,
      status: map['status'] as bool,
      statusUpdateDate:
          DateTime.tryParse(map['statusUpdateDate']) ?? WeebiDates.defaultDate,
      creationDate:
          DateTime.tryParse(map['creationDate']) ?? WeebiDates.defaultDate,
      // isInDash: map['isInDash'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'oid': oid,
      'shopId': shopId,
      'items': items.map((x) => x.toMap()).toList(),
      'taxe': taxe.toMap(),
      'promo': promo,
      'comment': comment,
      'contactPastPurchasingPower': contactPastPurchasingPower,
      'received': received,
      'date': date.toIso8601String(),
      'paiementType': paiementType.toString(),
      'ticketType': ticketType.toString(),
      'contactInfo': contactInfo,
      'status': status,
      'statusUpdateDate': statusUpdateDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'isInDash': isInDash,
    };
  }

  TicketWeebi copyWith({
    String? oid,
    int? id,
    String? shopId,
    List<ItemCartWeebi>? items,
    TaxeWeebi? taxe,
    double? promo,
    String? comment,
    String? contactPastPurchasingPower,
    int? received,
    DateTime? date,
    PaiementType? paiementType,
    TicketType? ticketType,
    String? contactInfo,
    bool? status,
    DateTime? statusUpdateDate,
    DateTime? creationDate,
    bool? isInDash,
  }) {
    return TicketWeebi(
      oid: oid ?? this.oid,
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      items: items ??
          this.items.map((e) => e).toList(), // a real copy, not a reference
      taxe: taxe ?? this.taxe,
      promo: promo ?? this.promo,
      comment: comment ?? this.comment,
      contactPastPurchasingPower:
          contactPastPurchasingPower ?? this.contactPastPurchasingPower,
      received: received ?? this.received,
      date: date ?? this.date,
      paiementType: paiementType ?? this.paiementType,
      ticketType: ticketType ?? this.ticketType,
      contactInfo: contactInfo ?? this.contactInfo,
      status: status ?? this.status,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      creationDate: creationDate ?? this.creationDate,
    );
  }
}
