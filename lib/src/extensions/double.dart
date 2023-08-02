import 'dart:math';

extension RoundDecimals on num {
  double get roundTwoDecimals {
    num fac = pow(10, 2);
    final d = (this * fac).round() / fac;
    return d;
  }
}

extension RoundNumDecimals on num {
  double get roundFourDecimals {
    num fac = pow(10, 4);
    return (this * fac).round() / fac;
  }
}
