import 'package:models_weebi/weebi_models.dart';
import 'package:test/test.dart';

void main() {
  test('basket decimal', () async {
    final items = <ItemCartWeebi>[
      ItemCartWeebi(() => ArticleRetail.dummy, 1.5),
    ];
    final dd = TicketWeebi.dummySell.copyWith(items: items);
    for (final i in items) {
      print(i.quantity);
    }

    expect(ArticleRetail.dummy.price * 1.5, dd.totalPriceTaxAndPromoIncluded);
  });
}
