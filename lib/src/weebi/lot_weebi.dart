import 'dart:convert';

import 'package:models_base/base.dart' show LotAbstract;

class LotWeebi extends LotAbstract {
  final String? shopUuid; // distinguish shops data in backend db
  final double
      minimumUnitPerBasket; // putting this here before inserting it into base

  LotWeebi({
    required int lineId,
    required int articleId,
    required int id,
    required int proxyLineId,
    required int proxyArticleId,
    required this.shopUuid,
    required this.minimumUnitPerBasket,
    bool status = true,
  }) : super(
          lineId: lineId,
          articleId: articleId,
          id: id,
          proxyLineId: proxyLineId,
          proxyArticleId: proxyArticleId,
          status: status,
        );

  static final dummy = LotWeebi(
    lineId: 1,
    articleId: 1,
    id: 1,
    proxyLineId: 1,
    proxyArticleId: 1,
    minimumUnitPerBasket: 1.0,
    shopUuid: '',
  );

  LotWeebi copyWith({
    int? lineId,
    int? articleId,
    int? id,
    int? proxyLineId,
    int? proxyArticleId,
    bool? status,
    String? shopUuid,
    double? minimumUnitPerBasket,
  }) {
    return LotWeebi(
      lineId: lineId ?? this.lineId,
      articleId: articleId ?? this.articleId,
      id: id ?? this.id,
      proxyArticleId: proxyArticleId ?? this.proxyArticleId,
      proxyLineId: proxyLineId ?? this.proxyLineId,
      status: status ?? this.status,
      shopUuid: shopUuid ?? this.shopUuid,
      minimumUnitPerBasket: minimumUnitPerBasket ?? this.minimumUnitPerBasket,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'lineId': lineId,
      'articleId': articleId,
      'id': id,
      'proxyArticleId': proxyArticleId,
      'proxyLineId': proxyLineId,
      'shopUuid': shopUuid,
      'status': status,
      'minimumUnitPerBasket': minimumUnitPerBasket,
    };
  }

  factory LotWeebi.fromMap(Map<String, dynamic> map) {
    return LotWeebi(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      articleId: map['articleId'] as int,
      id: map['id'],
      proxyLineId: map['proxyLineId'],
      proxyArticleId: map['proxyArticleId'],
      shopUuid: map['shopUuid'],
      status: map['status'] ?? true,
      minimumUnitPerBasket: map['minimumUnitPerBasket'],
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
        other.id == id &&
        other.proxyLineId == proxyLineId &&
        other.proxyArticleId == proxyArticleId &&
        minimumUnitPerBasket == minimumUnitPerBasket;
  }

  @override
  @override
  int get hashCode =>
      lineId.hashCode ^
      articleId.hashCode ^
      id.hashCode ^
      shopUuid.hashCode ^
      minimumUnitPerBasket.hashCode ^
      proxyLineId.hashCode ^
      proxyArticleId.hashCode;
}
