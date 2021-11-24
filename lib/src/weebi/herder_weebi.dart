import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:models_base/base.dart' show HerderAbstract;
import 'package:models_base/utils.dart';

class HerderWeebi extends HerderAbstract {
  HerderWeebi({
    required final int id,
    required int bidon,
    required String firstName,
    required String lastName,
    required DateTime? updateDate,
    required DateTime? statusUpdateDate,
    required bool status,
    required bool isWoman,
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
      ..writeln('nom : $lastName');
    return sb.toString();
  }

  // only override if add specific field
  // @override Map<String, dynamic> toMap()

  @override
  String toJson() => json.encode(toMap());

  factory HerderWeebi.fromMap(Map<String, dynamic> map) {
    return HerderWeebi(
      id: map['id'],
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
  factory HerderWeebi.fromJson(String source) =>
      HerderWeebi.fromMap(json.decode(source));

// TODO implement getContactsWeebi endpoint
//  static Future<List<Herder>> getContactsWeebi(bool isProd) async {

  HerderWeebi copyWith({
    int? id,
    int? bidon,
    String? firstName,
    String? lastName,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
    bool? isWoman,
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
    return HerderWeebi(
      id: id ?? this.id,
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
      carteNFC: carteNFC ?? this.carteNFC,
      pointCollecte: pointCollecte ?? this.pointCollecte,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HerderAbstract &&
        other.area == area &&
        other.bank == bank &&
        other.identity == identity &&
        other.category == category &&
        other.qrcode == qrcode &&
        other.milkMonthQuota == milkMonthQuota &&
        other.isWoman == isWoman &&
        other.carteNFC == carteNFC &&
        other.pointCollecte == pointCollecte;
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
        carteNFC.hashCode ^
        pointCollecte.hashCode;
  }
}
