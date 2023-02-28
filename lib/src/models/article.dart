import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:models_base/base.dart' show ArticleAbstract;
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/models/price_and_cost.dart';

// ** this should be in models_base
// once and only once i deploy the latest build in iOS
class PhotoSource {
  final String _imageSource;
  const PhotoSource._(this._imageSource);

  @override
  String toString() => _imageSource;

  static const PhotoSource asset = PhotoSource._('asset');
  static const PhotoSource file = PhotoSource._('file');
  static const PhotoSource memory = PhotoSource._('memory');
  static const PhotoSource network = PhotoSource._('network');
  static const PhotoSource unknown = PhotoSource._('unknown');

  static PhotoSource tryParse(String val) {
    switch (val) {
      case 'asset':
        return PhotoSource.asset;
      case 'file':
        return PhotoSource.file;
      case 'memory':
        return PhotoSource.memory;
      case 'network':
        return PhotoSource.network;
      case '':
        return PhotoSource.unknown;
      default:
        print('$val is not a valid ImageSource');
        return PhotoSource.unknown;
    }
  }
}

class Article extends ArticleAbstract implements PriceAndCostAbstract {
  @override
  final int price;
  @override
  final int cost;
  final PhotoSource photoSource;
  int get codeShortcut => articleCode ?? id;
  DateTime? statusUpdateDate;
  String? codeEAN;
  Article(
      { //this.shopUuid,
      required this.price,
      this.cost = 0,
      required int lineId,
      required int id,
      required String fullName,
      double weight = 1.0,
      int? articleCode,
      String? photo = '',
      this.photoSource = PhotoSource.unknown,
      required DateTime? creationDate,
      required DateTime? updateDate,
      this.statusUpdateDate,
      this.codeEAN = '',
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
        );

  static final dummy = Article(
    // shopUuid: 'shopUuid',
    lineId: 1,
    id: 1,
    fullName: 'dummy',
    price: 100,
    cost: 80,
    weight: 1,
    articleCode: 1,
    photo: 'photo',
    codeEAN: 'photo',
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
  codeEAN: $codeEAN,
)
""";
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      // 'shopUuid': shopUuid,
      'lineId': lineId,
      'id': id,
      'codeEAN': codeEAN,
      'fullName': fullName,
      'price': price,
      'cost': cost,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'photo': photo ?? '',
      'creationDate': creationDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'statusUpdateDate': statusUpdateDate?.toIso8601String() ??
          WeebiDates.defaultDate.toIso8601String(),
      'status': status,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      lineId: map['lineId'] == null
          ? map['productId'] as int
          : map['lineId'] as int,
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      price: map['price'] as int,
      cost: map['cost'] as int,
      weight: map['weight'] == null ? 1.0 : (map['weight'] as num).toDouble(),
      articleCode: map['articleCode'] ?? 0,
      codeEAN: map['codeEAN'] as String,
      photo: map['photo'] ?? '',
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

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source));

  Article copyWith({
    // String? shopUuid,
    int? lineId,
    int? id,
    String? fullName,
    int? price,
    int? cost,
    double? weight,
    int? articleCode,
    String? photo,
    String? codeEAN,
    DateTime? creationDate,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
  }) {
    return Article(
      // shopUuid: shopUuid ?? this.shopUuid,
      lineId: lineId ?? this.lineId,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      price: price ?? this.price,
      cost: cost ?? this.cost,
      weight: weight ?? this.weight,
      articleCode: articleCode ?? this.articleCode,
      codeEAN: codeEAN ?? this.codeEAN,
      photo: photo ?? this.photo,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Article &&
        // other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.lineId == lineId &&
        other.codeEAN == codeEAN &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode => id.hashCode ^ lineId.hashCode ^ id.hashCode;
}
