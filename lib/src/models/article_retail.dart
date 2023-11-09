import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart' show ArticleAbstract;
import 'package:models_weebi/common.dart';
import 'package:models_weebi/utils.dart';
import 'package:models_weebi/src/models/price_and_cost.dart';

class ArticleRetail extends ArticleAbstract implements Price, Cost {
  @override
  final num price;
  num get priceClean => num.parse(Price(price).toString());

  @override
  final num cost;
  num get costClean => num.parse(Cost(cost).toString());

  int get codeShortcut => articleCode ?? id;
  String barcodeEAN;

  // ? update in models_base ?
  double get unitsPerPiece => weight;
  ArticleRetail(
      { //this.shopUuid,
      required this.price,
      this.cost = 0,
      required int calibreId,
      required int id,
      required String fullName,
      double weight = 1.0,
      int? articleCode,
      required DateTime creationDate,
      DateTime? updateDate,
      DateTime? statusUpdateDate,
      this.barcodeEAN = '',
      @observable bool status = true})
      : super(
          calibreId: calibreId,
          id: id,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          creationDate: creationDate,
          updateDate: updateDate,
          statusUpdateDate: statusUpdateDate,
          status: status,
        );

  static final dummy = ArticleRetail(
    // shopUuid: 'shopUuid',
    calibreId: 1,
    id: 1,
    fullName: 'dummy',
    price: 100,
    cost: 80,
    weight: 1,
    articleCode: 1,
    barcodeEAN: 'barcodeEAN',
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    statusUpdateDate: WeebiDates.defaultDate,
    status: true,
  );

  static final dummyDecimal = ArticleRetail(
    // shopUuid: 'shopUuid',
    calibreId: 3,
    id: 1,
    fullName: 'dummy',
    price: 9.99,
    cost: 7.4,
    weight: 1,
    articleCode: 1,
    barcodeEAN: 'barcodeEAN',
    creationDate: WeebiDates.defaultDate,
    status: true,
  );

  @override
  String toString() {
    return """
ArticleWeebi(
  calibreId: $calibreId,
  id: $id,
  fullName: '$fullName',
  price: $price,
  cost: $cost,
  weight: $weight,
  articleCode: $articleCode,
  creationDate: $creationDate,
  updateDate: $updateDate,
  statusUpdateDate: $statusUpdateDate,
  status: $status,
  barcodeEAN: $barcodeEAN,
)
""";
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'calibreId': calibreId,
      'id': id,
      'barcodeEAN': barcodeEAN,
      'fullName': fullName,
      'price': price,
      'cost': cost,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String(),
      'statusUpdateDate': statusUpdateDate?.toIso8601String(),
      'status': status,
    };
  }

  factory ArticleRetail.fromMap(Map<String, dynamic> map) {
    return ArticleRetail(
      calibreId: map['calibreId'] != null
          ? map['calibreId'] as int
          : map['lineId'] != null
              ? map['lineId'] as int
              : map['productId'] as int,
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      price: Price(map['price'] as num).price,
      cost: Cost(map['cost'] as num).cost,
      weight: map['weight'] == null ? 1.0 : (map['weight'] as num).toDouble(),
      articleCode: map['articleCode'] ?? 0,
      barcodeEAN: (map['barcodeEAN'] ?? '') as String,
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      // shopUuid: map['shopUuid'] ?? '',
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ArticleRetail.fromJson(String source) =>
      ArticleRetail.fromMap(json.decode(source));

  ArticleRetail copyWith({
    int? calibreId,
    int? id,
    String? fullName,
    num? price,
    num? cost,
    double? weight,
    int? articleCode,
    String? photo,
    PhotoSource? photoSource,
    String? barcodeEAN,
    DateTime? creationDate,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
  }) {
    return ArticleRetail(
      calibreId: calibreId ?? this.calibreId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      barcodeEAN: barcodeEAN ?? this.barcodeEAN,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleRetail &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.calibreId == calibreId &&
        other.barcodeEAN == barcodeEAN &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode => id.hashCode ^ calibreId.hashCode ^ creationDate.hashCode;
}
