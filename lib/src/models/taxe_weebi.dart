import 'dart:convert';

import 'package:models_base/base.dart' show TaxAbstract;

class TaxWeebi extends TaxAbstract {
  const TaxWeebi(
    final String id,
    final String name,
    final double percentage,
  ) : super(id: id, name: name, percentage: percentage);

  static const noTax = TaxWeebi('1', 'HT 0%', 0.0);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
    };
  }

  factory TaxWeebi.fromMap(Map<String, dynamic> map) {
    return TaxWeebi(
      map['id'],
      map['name'],
      map['percentage'] == null ? 0.0 : (map['percentage'] as num).toDouble(),
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory TaxWeebi.fromJson(String source) =>
      TaxWeebi.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    return other is TaxWeebi &&
        other.name == name &&
        other.id == id &&
        other.percentage == percentage;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ percentage.hashCode;
}
