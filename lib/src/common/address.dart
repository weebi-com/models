// Dart imports:
import 'dart:convert';

import 'package:models_weebi/common.dart';
import 'package:models_weebi/src/common/country.dart';

class Address {
  final String street;
  final String code;
  final String city;
  final Country country;
  final double latitude;
  final double longitude;
  const Address(this.street, this.city, this.country,
      {this.code = '', this.latitude = 0.0, this.longitude = 0.0});

  const Address._empty(this.street, this.code, this.city, this.country,
      {this.latitude = 0.0, this.longitude = 0.0});

  static const addressEmpty = Address._empty('', '', '', Country.emptyCountry,
      latitude: 0.0, longitude: 0.0);

  Address copyWith({
    String? street,
    String? code,
    String? city,
    Country? country,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      street ?? this.street,
      city ?? this.city,
      country ?? this.country,
      code: code ?? this.code,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, Object> toMap() {
    return {
      'street': street,
      'city': city,
      'country': country.toMap(),
      'code': code,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      map['street'] ?? '',
      map['city'] ?? '',
      map['country'] != null
          ? Country.fromMap(map['country'])
          : Country.emptyCountry,
      code: map['code'] ?? '',
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(street: $street, code: $code, city: $city, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Address &&
        other.street == street &&
        other.code == code &&
        other.city == city &&
        other.country == country;
  }

  @override
  int get hashCode {
    return street.hashCode ^ code.hashCode ^ city.hashCode ^ country.hashCode;
  }
}
