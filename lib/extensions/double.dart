import 'dart:math';

extension RoundDecimals on double {
  double get roundTwoDecimals {
    num fac = pow(10, 2);
    final d = (this * fac).round() / fac;
    return d;
  }
}
