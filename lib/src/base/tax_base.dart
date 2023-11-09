import 'dart:convert';

abstract class TaxAbstract {
  final String id;
  final String name;
  final double percentage;

  const TaxAbstract(
      {required this.id, required this.name, required this.percentage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'percentage': percentage,
    };
  }

  String toJson() => json.encode(toMap());
}
