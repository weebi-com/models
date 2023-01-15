// until goes into weebni_models
// meanwhile

import 'package:models_weebi/weebi_models.dart';

class BasketWrapper {
  final Article article;
  final double minimumUnitPerBasket;
  final double stockRemaining;
  const BasketWrapper(
      this.article, this.minimumUnitPerBasket, this.stockRemaining);

  BasketWrapper copyWith({
    Article? article,
    double? minimumUnitPerBasket,
    double? stockRemaining,
  }) {
    return BasketWrapper(
      article ?? this.article,
      minimumUnitPerBasket ?? this.minimumUnitPerBasket,
      stockRemaining ?? this.stockRemaining,
    );
  }
}
