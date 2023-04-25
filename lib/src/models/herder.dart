import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:models_base/base.dart' show HerderAbstract;
import 'package:models_base/utils.dart';
import 'package:models_weebi/src/extensions/string_no_accents.dart';

//TODO  faire évoluer isWoman en sex ou gender, avec man/woman/other/unknown

class Gender {
  final String _gender;
  const Gender._(this._gender);

  @override
  String toString() => _gender;

  static const Gender woman = Gender._('woman');
  static const Gender man = Gender._('man');
  static const Gender other = Gender._('other');
  static const Gender unknown = Gender._('unknown');

  static Gender tryParse(String val) {
    switch (val) {
      case 'woman':
        return Gender.woman;
      case 'man':
        return Gender.man;
      case 'other':
        return Gender.other;
      case 'unknown':
        return Gender.unknown;
      default:
        print('$val is not a valid gender');
        return Gender.unknown;
    }
  }

  static String paiementString(Gender gender) {
    if (gender == Gender.woman) {
      return 'Femme';
    } else if (gender == Gender.man) {
      return 'Homme';
    } else if (gender == Gender.other) {
      return 'Autre';
    } else if (gender == Gender.unknown) {
      return 'Inconnu';
    } else {
      return 'Inconnu';
    }
  }
}

class Herder extends HerderAbstract {
  // final String shopId;
  // String get shopUuid => shopId;

  String get fullName => firstName + ' ' + lastName;
  int get fullNameHash => (firstName.withoutAccents.toLowerCase().trim() +
          lastName.withoutAccents.toLowerCase().trim())
      .hashCode;
  int get mailHash => mail.withoutAccents.toLowerCase().trim().hashCode;
  int get telHash => tel.toLowerCase().trim().hashCode;

  // TODO move away from Herder to Contact
  Gender gender;
  Herder({
    required final int id,
    required int bidon,
    required String firstName,
    // required this.shopId,
    required String lastName,
    required DateTime? updateDate,
    required DateTime? statusUpdateDate,
    required bool status,
    required bool isWoman,
    this.gender = Gender.unknown,
    String area = '',
    String bank = '',
    String identity = '',
    String category = '',
    String carteNFC = '',
    String pointCollecte = '',
    String qrcode = '',
    String tel = '',
    String mail = '',
    String address = '',
    String avatar = '',
    int overdraft = 0,
    int milkMonthQuota = 0,
  }) : super(
          id: id,
          bidon: bidon,
          firstName: firstName,
          lastName: lastName,
          updateDate: updateDate,
          statusUpdateDate: statusUpdateDate,
          status: status,
          tel: tel,
          mail: mail,
          address: address,
          avatar: avatar,
          overdraft: overdraft,
          milkMonthQuota: milkMonthQuota,
          area: area,
          bank: bank,
          category: category,
          qrcode: qrcode,
          identity: identity,
          isWoman: isWoman,
          carteNFC: carteNFC,
          pointCollecte: pointCollecte,
        );

  String get sharableText {
    final sb = StringBuffer()
      ..writeln('bid : $bidon')
      ..writeln('prenom : $firstName')
      ..writeln('nom : $lastName')
      ..writeln('tel : $tel');
    return sb.toString();
  }

  // only override if add specific field
  // @override Map<String, dynamic> toMap()

  static final dummy = Herder(
    id: 0,
    // shopId: 'dummy',
    bidon: 0,
    firstName: 'inconnu',
    lastName: 'John Doe',
    tel: '',
    mail: 'john@doe.com',
    updateDate: WeebiDates.defaultDate,
    statusUpdateDate: WeebiDates.defaultDate,
    status: true,
    isWoman: false,
  );

  @override
  String toJson() => json.encode(toMap());

  factory Herder.fromMap(Map<String, dynamic> map) {
    return Herder(
      id: map['id'],
      // shopId: map['shopId'] ?? 'no_shopId',
      bidon: map['bidon'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      tel: map['tel'],
      mail: map['mail'],
      address: map['address'],
      avatar: map['avatar'],
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      status: map['status'],
      overdraft: map['overdraft'],
      gender: Gender.tryParse(map['gender'] as String),
      area: map['area'],
      bank: map['bank'],
      identity: map['identity'],
      category: map['category'],
      qrcode: map['qrcode'],
      milkMonthQuota: map['milkMonthQuota'],
      isWoman: map['isWoman'],
      carteNFC: map['carteNFC'],
      pointCollecte: map['pointCollecte'],
    );
  }
  factory Herder.fromJson(String source) => Herder.fromMap(json.decode(source));

  Herder copyWith({
    int? id,
    String? shopId,
    int? bidon,
    String? firstName,
    String? lastName,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
    bool? isWoman,
    Gender? gender,
    String? area,
    String? bank,
    String? identity,
    String? category,
    String? qrcode,
    String? tel,
    String? mail,
    String? address,
    String? avatar,
    int? overdraft,
    int? milkMonthQuota,
    String? carteNFC,
    String? pointCollecte,
  }) {
    return Herder(
      id: id ?? this.id,
      // shopId: shopId ?? this.shopId,
      bidon: bidon ?? this.bidon,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      updateDate: updateDate ?? this.updateDate,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      status: status ?? this.status,
      tel: tel ?? this.tel,
      mail: mail ?? this.mail,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
      overdraft: overdraft ?? this.overdraft,
      milkMonthQuota: milkMonthQuota ?? this.milkMonthQuota,
      area: area ?? this.area,
      bank: bank ?? this.bank,
      identity: identity ?? this.identity,
      category: category ?? this.category,
      qrcode: qrcode ?? this.qrcode,
      isWoman: isWoman ?? this.isWoman,
      gender: gender ?? this.gender,
      carteNFC: carteNFC ?? this.carteNFC,
      pointCollecte: pointCollecte ?? this.pointCollecte,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HerderAbstract &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return area.hashCode ^
        bank.hashCode ^
        identity.hashCode ^
        category.hashCode ^
        qrcode.hashCode ^
        milkMonthQuota.hashCode ^
        isWoman.hashCode ^
        gender.hashCode ^
        carteNFC.hashCode ^
        pointCollecte.hashCode;
  }
}
