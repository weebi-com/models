import 'package:models_weebi/base.dart';

abstract class BasketAbstract<P extends ArticleProxyAbstract> {
  final List<P>? proxiesWorth;
  const BasketAbstract(this.proxiesWorth);
}
