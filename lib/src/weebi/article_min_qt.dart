import 'package:mobx/mobx.dart';
import 'package:models_weebi/weebi_models.dart' show ArticleWeebi;

class ArticleWMinQt extends ArticleWeebi {
  double minQt = 1.0;
  ArticleWMinQt(
    this.minQt, {
    required String? shopUuid,
    required int lineId,
    required int id,
    required int price,
    required int cost,
    required String fullName,
    double weight = 1.0,
    int? articleCode,
    String? photo = '',
    required DateTime? creationDate,
    required DateTime? updateDate,
    @observable bool status = false,
  }) : super(
          shopUuid: shopUuid,
          lineId: lineId,
          id: id,
          price: price,
          cost: cost,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo,
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArticleWMinQt &&
        other.shopUuid == shopUuid &&
        other.cost == cost &&
        other.price == price &&
        other.fullName == fullName &&
        other.id == id &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  @override
  int get hashCode => shopUuid.hashCode;
}
