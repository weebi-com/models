import 'dart:convert';

import 'package:models_weebi/common.dart' show ContactAbstract;

abstract class HerderAbstract extends ContactAbstract {
  final String area; // pole laitier
  final String bank; // numero de compte
  final String identity; // sepcific ldb
  final String category; // sepcific ldb
  final String qrcode; // sepcific ldb
  final int milkMonthQuota; // specific to ldb,
  final int bidon;
  final bool isWoman; // ie sex
  final String carteNFC;
  final String pointCollecte;
  final String address; // axe de collecte

  const HerderAbstract({
    //
    // Milky attributes below
    required this.isWoman,
    required this.bidon,
    required this.area,
    required this.bank,
    required this.identity,
    required this.category,
    required this.qrcode,
    required this.milkMonthQuota,
    required this.carteNFC,
    required this.pointCollecte,
    this.address = '',
    //
    // Contact inherited attributes below
    required final int id,
    required String firstName,
    required String lastName,
    required DateTime? updateDate,
    required DateTime? statusUpdateDate,
    required bool status,
    String tel = '',
    String mail = '',
    String avatar = '',
    int overdraft = 0,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          updateDate: updateDate,
          statusUpdateDate: statusUpdateDate,
          status: status,
          tel: tel,
          mail: mail,
          avatar: avatar,
          overdraft: overdraft,
        );

  @override
  Map<String, Object> toMap() {
    return {
      'id': id,
      'bidon': bidon,
      'firstName': firstName,
      'lastName': lastName,
      'tel': tel,
      'mail': mail,
      'address': address,
      'avatar': avatar,
      'updateDate': updateDate == null ? '' : updateDate!.toIso8601String(),
      'statusUpdateDate':
          statusUpdateDate == null ? '' : statusUpdateDate!.toIso8601String(),
      'status': status,
      'overdraft': overdraft,
      'area': area,
      'bank': bank,
      'identity': identity,
      'category': category,
      'qrcode': qrcode,
      'milkMonthQuota': milkMonthQuota,
      'isWoman': isWoman,
      'carteNFC': carteNFC,
      'pointCollecte': pointCollecte,
    };
  }

  @override
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HerderAbstract &&
        other.area == area &&
        other.bank == bank &&
        other.identity == identity &&
        other.category == category &&
        other.qrcode == qrcode &&
        other.address == address &&
        other.milkMonthQuota == milkMonthQuota &&
        other.bidon == bidon &&
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
        address.hashCode ^
        milkMonthQuota.hashCode ^
        bidon.hashCode ^
        isWoman.hashCode ^
        carteNFC.hashCode ^
        pointCollecte.hashCode;
  }
}
