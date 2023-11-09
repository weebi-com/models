import 'dart:convert';

import 'package:mobx/mobx.dart';

abstract class ArticleAbstract {
  final int calibreId;
  int get productId => calibreId;
  int get lineId => calibreId;
  final int id;
  final String fullName;

  final double weight;
  final int? articleCode;

  @observable
  final bool status;
  final DateTime creationDate;
  final DateTime? updateDate;
  final DateTime? statusUpdateDate;

  const ArticleAbstract({
    required this.calibreId,
    required this.id,
    required this.fullName,
    this.weight = 1.0,
    required this.creationDate,
    this.updateDate,
    this.statusUpdateDate,
    this.articleCode,
    required this.status,
  });

  String nameWithoutProductPart(String productTitle) {
    String name;
    if (productTitle.length < fullName.length &&
        fullName.contains(productTitle)) {
      name = fullName.substring(productTitle.length);
    } else {
      name = fullName;
    }
    return name.trim();
  }

  @override
  String toString() {
    return """
Article(
  calibreId: $calibreId,
  id: $id,
  fullName: '$fullName',
  creationDate: $creationDate,
  updateDate: $updateDate,
  statusUpdateDate: $statusUpdateDate,
  weight: $weight,
  articleCode: $articleCode,
  status: $status,
)
""";
  }

  Map<String, dynamic> toMap() {
    return {
      'calibreId': calibreId,
      'id': id,
      'fullName': fullName,
      'weight': weight,
      'articleCode': articleCode ?? 0,
      'creationDate': creationDate.toIso8601String(),
      'updateDate': updateDate?.toIso8601String(),
      'statusUpdateDate': statusUpdateDate?.toIso8601String(),
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticleAbstract &&
        other.calibreId == calibreId &&
        other.id == id &&
        other.fullName == fullName &&
        other.weight == weight &&
        other.articleCode == articleCode &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate &&
        other.statusUpdateDate == statusUpdateDate &&
        other.status == status;
  }

  @override
  int get hashCode {
    return calibreId.hashCode ^
        id.hashCode ^
        fullName.hashCode ^
        weight.hashCode ^
        articleCode.hashCode ^
        creationDate.hashCode ^
        updateDate.hashCode ^
        statusUpdateDate.hashCode ^
        status.hashCode;
  }
}
