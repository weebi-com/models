import 'package:mobx/mobx.dart';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/utils.dart';

class ArticleWMinQt extends ArticleAbstract {
  double minQt = 1.0;
  ArticleWMinQt(
    this.minQt, {
    required int calibreId,
    required int id,
    required String fullName,
    required double weight,
    int? articleCode,
    String? photo = '',
    required DateTime creationDate,
    required DateTime updateDate,
    @observable bool status = false,
  }) : super(
          calibreId: calibreId,
          id: id,
          fullName: fullName,
          weight: weight,
          articleCode: articleCode,
          photo: photo ?? '',
          creationDate: creationDate,
          updateDate: updateDate,
          status: status,
        );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ArticleWMinQt &&
        other.fullName == fullName &&
        other.id == id &&
        other.calibreId == calibreId &&
        other.photo == photo &&
        other.creationDate == creationDate &&
        other.updateDate == updateDate;
  }

  static get dummy => ArticleWMinQt(1,
      calibreId: 1,
      id: 1,
      weight: 1,
      fullName: 'dummy',
      creationDate: WeebiDates.defaultDate,
      updateDate: WeebiDates.defaultDate);

  @override
  int get hashCode => id.hashCode ^ fullName.hashCode;
}
