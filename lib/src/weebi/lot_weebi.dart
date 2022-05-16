import 'dart:convert';
import 'package:models_base/base.dart' show LotAbstract;
import 'package:models_base/utils.dart';

class LotWeebi extends LotAbstract {
  final String? shopUuid;
  DateTime? dlc;
  double quantity;
  double initialQuantity;

  LotWeebi({
    required int id,
    required int articleId,
    required int productId,
    bool isDefault = true,
    DateTime? creationDate,
    this.shopUuid,
    this.dlc,
    this.quantity = 0.0,
    this.initialQuantity = 0.0,
  }) : super(
          id: id,
          articleId: articleId,
          productId: productId,
          isDefault: isDefault,
          creationDate: creationDate,
        );

  static final dummy = LotWeebi(
    id: 1,
    articleId: 1,
    productId: 1,
    isDefault: true,
    creationDate: WeebiDates.defaultDate,
  );

  LotWeebi copyWith({
    int? id,
    int? articleId,
    int? productId,
    bool? isDefault,
    DateTime? creationDate,
    String? shopUuid,
    DateTime? dlc,
    double? quantity,
    double? initialQuantity,
  }) {
    return LotWeebi(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      productId: productId ?? this.productId,
      isDefault: isDefault ?? this.isDefault,
      creationDate: creationDate ?? this.creationDate,
      shopUuid: shopUuid ?? this.shopUuid,
      dlc: dlc ?? this.dlc,
      quantity: quantity ?? this.quantity,
      initialQuantity: initialQuantity ?? this.initialQuantity,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'articleId': articleId,
      'productId': productId,
      'isDefault': isDefault,
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'shopUuid': shopUuid,
      // 'dlc': dlc?.toIso8601String(),
      // 'quantity': quantity,
      // 'initialQuantity': initialQuantity,
    };
  }

  factory LotWeebi.fromMap(Map<String, dynamic> map) {
    return LotWeebi(
      id: map['id'],
      articleId: map['articleId'],
      productId: map['productId'],
      isDefault: map['isDefault'] ?? true,
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      shopUuid: map['shopUuid'],
      //dlc: map['dlc'] == null
      //    ? WeebiDates.defaultDate
      //    : DateTime.parse(map['dlc']),
      // quantity: map['quantity'],
      // initialQuantity: map['initialQuantity'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory LotWeebi.fromJson(String source) =>
      LotWeebi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Lot(shopUuid: $shopUuid, dlc: $dlc, quantity: $quantity, initialQuantity: $initialQuantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LotWeebi &&
        other.shopUuid == shopUuid &&
        other.dlc == dlc &&
        other.quantity == quantity &&
        other.initialQuantity == initialQuantity;
  }

  @override
  int get hashCode {
    return shopUuid.hashCode ^
        dlc.hashCode ^
        quantity.hashCode ^
        initialQuantity.hashCode;
  }
}
