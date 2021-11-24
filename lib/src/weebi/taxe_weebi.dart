import 'dart:convert';

import 'package:models_base/base.dart' show TaxeAbstract;

class TaxeWeebi extends TaxeAbstract {
  const TaxeWeebi(
    final String id,
    final String name,
    final double percentage,
  ) : super(id: id, name: name, percentage: percentage);

  static const noTax = TaxeWeebi('1', 'HT 0%', 0.0);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
    };
  }

  factory TaxeWeebi.fromMap(Map<String, dynamic> map) {
    return TaxeWeebi(
      map['id'],
      map['name'],
      map['percentage'] == null ? 0.0 : (map['percentage'] as num).toDouble(),
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory TaxeWeebi.fromJson(String source) =>
      TaxeWeebi.fromMap(json.decode(source));
}
