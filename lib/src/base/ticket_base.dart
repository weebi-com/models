// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';

import 'package:models_weebi/src/base/item_base.dart';
import 'package:models_weebi/src/base/tax_base.dart';
import 'package:models_weebi/src/common/paiement_type.dart';
import 'package:models_weebi/src/common/ticket_type.dart';

abstract class TicketAbstract<I extends ItemAbstract, T extends TaxAbstract> {
  final int id;
  final String shopUuid;
  final List<I> items;
  final T taxe;
  final double promo;
  final String comment; // comment
  final num received;
  final DateTime date;
  final PaiementType paiementType;
  final TicketType ticketType;
  final String herderIdString;
  @observable
  final bool status;
  final DateTime statusUpdateDate;
  final DateTime
      creationDate; // * using it as unique Key? to display the ticket
  @observable
  final bool isInDash; // this will be problematic in yobi copywith all is slow

  const TicketAbstract({
    required this.id,
    required this.shopUuid,
    required this.items,
    required this.taxe,
    this.promo = 0.0,
    this.comment = '',
    required this.received,
    required this.date,
    required this.paiementType,
    required this.ticketType,
    required this.herderIdString,
    required this.status,
    required this.statusUpdateDate,
    required this.creationDate,
    this.isInDash = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopUuid': shopUuid,
      'items': items.map((x) => x.toMap()).toList(),
      'taxe': taxe.toMap(),
      'promo': promo,
      'comment': comment,
      'received': received,
      'date': date.toIso8601String(),
      'paiementType': paiementType.toString(),
      'ticketType': ticketType.toString(),
      'herderId': herderIdString,
      'status': status,
      'statusUpdateDate': statusUpdateDate.toIso8601String(),
      'creationDate': creationDate.toIso8601String(),
      'isInDash': isInDash,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TicketAbstract<I, T> &&
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
        other.herderIdString == herderIdString &&
        other.status == status &&
        other.statusUpdateDate == statusUpdateDate &&
        other.creationDate == creationDate &&
        other.isInDash == isInDash;
  }

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
        herderIdString.hashCode ^
        status.hashCode ^
        statusUpdateDate.hashCode ^
        creationDate.hashCode ^
        isInDash.hashCode;
  }
}
