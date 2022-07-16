import 'dart:convert';

import 'package:models_base/base.dart' show LotAbstract;
import 'package:models_base/utils.dart';

class LotWeebi extends LotAbstract {
  final String? shopUuid;

  LotWeebi({
    required int lineId,
    required int articleId,
    required int id,
    bool isDefault = true,
    DateTime? creationDate,
    this.shopUuid,
  }) : super(
          lineId: lineId,
          articleId: articleId,
          id: id,
          isDefault: isDefault,
          creationDate: creationDate,
        );

  static final dummy = LotWeebi(
    lineId: 1,
    articleId: 1,
    id: 1,
    isDefault: true,
    creationDate: WeebiDates.defaultDate,
  );

  LotWeebi copyWith({
    int? lineId,
    int? articleId,
    int? id,
    bool? isDefault,
    DateTime? creationDate,
    String? shopUuid,
  }) {
    return LotWeebi(
      lineId: lineId ?? this.lineId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      isDefault: isDefault ?? this.isDefault,
      creationDate: creationDate ?? this.creationDate,
      shopUuid: shopUuid ?? this.shopUuid,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'lineId': lineId,
      'articleId': articleId,
      'id': id,
      'isDefault': isDefault,
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'shopUuid': shopUuid,
    };
  }

  factory LotWeebi.fromMap(Map<String, dynamic> map) {
    return LotWeebi(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      articleId: map['articleId'] as int,
      id: map['id'],
      isDefault: map['isDefault'] ?? true,
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      shopUuid: map['shopUuid'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory LotWeebi.fromJson(String source) =>
      LotWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LotWeebi &&
        other.shopUuid == shopUuid &&
        other.lineId == lineId &&
        other.articleId == articleId &&
        other.id == id;
  }

  @override
  int get hashCode =>
      shopUuid.hashCode ^ id.hashCode ^ articleId.hashCode ^ lineId.hashCode;
}
