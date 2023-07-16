import 'package:models_weebi/src/extensions/double.dart';

class Price {
  final num _priceRaw;
  num get price => num.parse(Price(_priceRaw).toString());

  const Price(this._priceRaw);

  /// rounding 4 decimals max, trimming if zero
  @override
  String toString() {
    if (_priceRaw is int) {
      return _priceRaw.toString();
    }

    final pDecimal4 = _priceRaw.roundFourDecimals.toStringAsFixed(4);
    if (pDecimal4.split('').last != '0') {
      return pDecimal4;
    } else {
      final pDecimal3 = pDecimal4.substring(0, pDecimal4.length - 1);
      if (pDecimal3.split('').last != '0') {
        return pDecimal3;
      } else {
        final pDecimal2 = pDecimal3.substring(0, pDecimal3.length - 1);
        if (pDecimal2.split('').last != '0') {
          return pDecimal2;
        } else {
          final pDecimal1 = pDecimal2.substring(0, pDecimal2.length - 1);
          if (pDecimal1.split('').last != '0') {
            return pDecimal1;
          } else {
            return pDecimal1.substring(0, pDecimal1.length - 2);
          }
        }
      }
    }
  }
}

class Cost {
  final num _costRaw;
  num get cost => num.parse(Cost(_costRaw).toString());
  const Cost(this._costRaw);

  /// rounding 4 decimals max, trimming if zero
  /// for saving / storing in db
  @override
  String toString() {
    final pDecimal4 = _costRaw.roundFourDecimals.toStringAsFixed(4);
    if (pDecimal4.split('').last != '0') {
      return pDecimal4;
    } else {
      final pDecimal3 = pDecimal4.substring(0, pDecimal4.length - 1);
      if (pDecimal3.split('').last != '0') {
        return pDecimal3;
      } else {
        final pDecimal2 = pDecimal3.substring(0, pDecimal3.length - 1);
        if (pDecimal2.split('').last != '0') {
          return pDecimal2;
        } else {
          final pDecimal1 = pDecimal2.substring(0, pDecimal2.length - 1);
          if (pDecimal1.split('').last != '0') {
            return pDecimal1;
          } else {
            return pDecimal1.substring(0, pDecimal1.length - 2);
          }
        }
      }
    }
  }
}
