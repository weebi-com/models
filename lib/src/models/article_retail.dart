import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleAbstract;
import 'package:models_base/common.dart';
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/price_and_cost.dart';

class ArticleRetail extends ArticleAbstract implements PriceAndCostAbstract {
  @override
  final int price;
  @override
  final int cost;
  int get codeShortcut => articleCode ?? id;
  DateTime? statusUpdateDate;
  String? barcodeEAN;

  // ? update in models_base ?
  double get unitsPerPiece => weight;
  ArticleRetail(
      { //this.shopUuid,
      required this.price,
      this.cost = 0,
      required int lineId,
      required int id,
      required String fullName,
      double weight = 1.0,
      int? articleCode,
      String? photo = '',
      PhotoSource photoSource = PhotoSource.unknown,
      required DateTime? creationDate,
      required DateTime? updateDate,
      this.statusUpdateDate,
      this.barcodeEAN = '',
      @observable bool status = true})
      : super(
          lineId: lineId,
          id: id,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
          photoSource: photoSource,
        );

  static final dummy = ArticleRetail(
    // shopUuid: 'shopUuid',
    lineId: 1,
    id: 1,
    fullName: 'dummy',
    price: 100,
    cost: 80,
    weight: 1,
    articleCode: 1,
    photo: 'photo',
    barcodeEAN: 'barcodeEAN',
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    statusUpdateDate: WeebiDates.defaultDate,
    status: true,
  );

  @override
  String toString() {
    return """
ArticleWeebi(
  lineId: $lineId,
  id: $id,
  fullName: '$fullName',
  price: $price,
  cost: $cost,
  weight: $weight,
  articleCode: $articleCode,
  photo: $photo,
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
      // 'shopUuid': shopUuid,
      'lineId': lineId,
      'id': id,
      'barcodeEAN': barcodeEAN,
      'fullName': fullName,
      'price': price,
      'cost': cost,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'photo': photo ?? '',
      'photoSource': photoSource.toString(),
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'statusUpdateDate': statusUpdateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'status': status,
    };
  }

  factory ArticleRetail.fromMap(Map<String, dynamic> map) {
    return ArticleRetail(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      price: map['price'] as int,
      cost: map['cost'] as int,
      weight: map['weight'] == null ? 1.0 : (map['weight'] as num).toDouble(),
      articleCode: map['articleCode'] ?? 0,
      barcodeEAN: map['barcodeEAN'] as String,
      photo: map['photo'] ?? '',
      photoSource: PhotoSource.tryParse(map['photoSource'] as String),
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
    // String? shopUuid,
    int? lineId,
    int? id,
    String? fullName,
    int? price,
    int? cost,
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
      // shopUuid: shopUuid ?? this.shopUuid,
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      barcodeEAN: barcodeEAN ?? this.barcodeEAN,
      photo: photo ?? this.photo,
      photoSource: photoSource ?? this.photoSource,
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
        // other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.lineId == lineId &&
        other.barcodeEAN == barcodeEAN &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode => id.hashCode ^ lineId.hashCode ^ creationDate.hashCode;
}
