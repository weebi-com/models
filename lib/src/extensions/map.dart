import 'package:models_base/base.dart' show HerderAbstract;
import 'package:models_weebi/utils.dart';

extension PrettyString<H extends HerderAbstract> on Map<String, H> {
  String mapToPrettyString() {
    List<String> reversedList = [];
    forEach((key, value) {
      reversedList.add(numFormat.format(int.parse(key)));
    });
    return reversedList.toString().replaceAll('[', '').replaceAll(']', '');
  }
}
