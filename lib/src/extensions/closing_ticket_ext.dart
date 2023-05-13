import 'package:models_weebi/closings.dart';
import 'package:models_weebi/base.dart';

extension ProductClosingBoyFeelsGoodAfterGulpingTBoneSteak<
    T extends TicketAbstract> on T {
  void incrementMyClosingStockPlease(List<ClosingStockProduct> stockProducts) {
    for (final item in items) {
      final thisCoolStockProduct = stockProducts
          .firstWhere((element) => element.id == item.article.productId);
      for (final cArticle in thisCoolStockProduct.articles) {
        if (cArticle.productId == item.article.productId &&
            cArticle.id == item.article.id) {
          if (ticketType.isShopInput) {
            cArticle.finalQtCl += item.quantity;
            cArticle.quantityIn += item.quantity;
            thisCoolStockProduct.finalQtCl +=
                item.quantity * cArticle.weight; // allows us to reconcile stock
          } else {
            cArticle.finalQtCl -= item.quantity;
            cArticle.quantityOut += item.quantity;
            thisCoolStockProduct.finalQtCl -=
                item.quantity * cArticle.weight; // same
          }
        }
      }
    }
  }

  void incrementClosingStockShop(
      List<ClosingStockShopProduct> stockShopProducts) {
    for (final item in items) {
      final stockShopProduct = stockShopProducts
          .firstWhere((element) => element.id == item.article.productId);
      for (final cArticle in stockShopProduct.articles) {
        if (cArticle.productId == item.article.productId &&
            cArticle.id == item.article.id) {
          if (ticketType.isShopInput) {
            cArticle.finalQtCl += item.quantity;
            cArticle.quantityIn += item.quantity;
            stockShopProduct.finalQtCl +=
                item.quantity * cArticle.weight; // allows us to reconcile stock
          } else {
            cArticle.finalQtCl -= item.quantity;
            cArticle.quantityOut += item.quantity;
            stockShopProduct.finalQtCl -=
                item.quantity * cArticle.weight; // same
          }
        }
      }
    }
  }
}
