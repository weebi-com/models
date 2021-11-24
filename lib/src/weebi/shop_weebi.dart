import 'dart:convert';

import 'package:models_base/base.dart' show ShopAbstract;
import 'package:models_base/utils.dart';

// consider adding
// * String appVersionBuildNumber
// * also add String emailResult

class ShopWeebi extends ShopAbstract {
  String gescom;
  ShopWeebi({
    required int id,
    required String uuid,
    required String name,
    required String tel,
    required bool status,
    required DateTime statusUpdateDate,
    required bool serverStatus,
    required DateTime serverStatusUpdateDate,
    required bool isProd,
    required bool isLocked,
    double promo = 0.0,
    required DateTime updateDate,
    this.gescom = '',
    String mail = '',
    String address = '',
    String lat = '',
    String long = '',
    String shopKeeperName = '',
    String shopKeeperTel = '',
    String shopKeeperMail = '',
  }) : super(
          id: id,
          managerMacAddress: '',
          uuid: uuid,
          name: name,
          tel: tel,
          mail: mail,
          address: address,
          lat: lat,
          long: long,
          shopKeeperName: shopKeeperName,
          shopKeeperTel: shopKeeperTel,
          shopKeeperMail: shopKeeperMail,
          status: status,
          statusUpdateDate: statusUpdateDate,
          serverStatus: serverStatus,
          serverStatusUpdateDate: serverStatusUpdateDate,
          isProd: isProd,
          isLocked: isLocked,
          promo: promo,
          updateDate: updateDate,
        );

  String get sharableText {
    final sb = StringBuffer()
      ..writeln('magasin : $name')
      ..writeln('tel : $tel')
      ..writeln('mail : $mail')
      ..writeln('adresse : $address')
      ..writeln('');
    return sb.toString();
  }

  static final unknownShopWeebi = ShopWeebi(
    id: 911,
    uuid: '',
    name: 'Magasin Inconnu',
    tel: '',
    mail: '',
    address: '',
    lat: '',
    long: '',
    shopKeeperName: '',
    shopKeeperTel: '',
    shopKeeperMail: '',
    updateDate: WeebiDates.defaultDate,
    status: false,
    statusUpdateDate: WeebiDates.defaultDate,
    serverStatus: false,
    serverStatusUpdateDate: WeebiDates.defaultDate,
    isProd: false,
    isLocked: false,
    promo: 0.0,
  );

  ShopWeebi copyWith({
    int? id,
    String? managerMacAddress,
    String? uuid,
    String? name,
    String? tel,
    String? gescom,
    String? mail,
    String? address,
    String? lat,
    String? long,
    String? shopKeeperName,
    String? shopKeeperTel,
    String? shopKeeperMail,
    DateTime? updateDate,
    bool? status,
    DateTime? statusUpdateDate,
    bool? serverStatus,
    DateTime? serverStatusUpdateDate,
    bool? isProd,
    bool? isLocked,
    double? promo,
  }) {
    return ShopWeebi(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      tel: tel ?? this.tel,
      mail: mail ?? this.mail,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      shopKeeperName: shopKeeperName ?? this.shopKeeperName,
      shopKeeperTel: shopKeeperTel ?? this.shopKeeperTel,
      shopKeeperMail: shopKeeperMail ?? this.shopKeeperMail,
      updateDate: updateDate ?? this.updateDate,
      status: status ?? this.status,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      serverStatus: serverStatus ?? this.serverStatus,
      serverStatusUpdateDate:
          serverStatusUpdateDate ?? this.serverStatusUpdateDate,
      isProd: isProd ?? this.isProd,
      isLocked: isLocked ?? this.isLocked,
      promo: promo ?? this.promo,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'tel': tel,
      'mail': mail,
      'address': address,
      'lat': lat,
      'long': long,
      'shopKeeperName': shopKeeperName,
      'shopKeeperTel': shopKeeperTel,
      'shopKeeperMail': shopKeeperMail,
      'updateDate': updateDate.toIso8601String(),
      'status': status,
      'statusUpdateDate': statusUpdateDate.toIso8601String(),
      'serverStatus': serverStatus,
      'serverStatusUpdateDate': serverStatusUpdateDate.toIso8601String(),
      'isProd': isProd,
      'isLocked': isLocked,
      'promo': promo,
    };
  }

  factory ShopWeebi.fromMap(Map<String, dynamic> map) {
    return ShopWeebi(
      id: map['id'],
      uuid: map['uuid'],
      name: map['name'],
      tel: map['tel'],
      mail: map['mail'],
      address: map['address'],
      lat: map['lat'],
      long: map['long'],
      shopKeeperName: map['shopKeeperName'],
      shopKeeperTel: map['shopKeeperTel'],
      shopKeeperMail: map['shopKeeperMail'],
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      status: map['status'],
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      serverStatus: map['serverStatus'],
      serverStatusUpdateDate: map['serverStatusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['serverStatusUpdateDate']),
      isProd: map['isProd'],
      isLocked: map['isLocked'],
      promo: map['promo'],
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory ShopWeebi.fromJson(String source) =>
      ShopWeebi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shop(id: $id, uuid: $uuid, name: $name, tel: $tel, mail: $mail, address: $address, lat: $lat, long: $long, shopKeeperName: $shopKeeperName, shopKeeperTel: $shopKeeperTel, shopKeeperMail: $shopKeeperMail, updateDate: $updateDate, status: $status, statusUpdateDate: $statusUpdateDate, serverStatus: $serverStatus, serverStatusUpdateDate: $serverStatusUpdateDate, isProd: $isProd, isLocked: $isLocked, promo: $promo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopWeebi &&
        other.id == id &&
        other.managerMacAddress == managerMacAddress &&
        other.uuid == uuid &&
        other.name == name &&
        other.tel == tel &&
        other.gescom == gescom &&
        other.mail == mail &&
        other.address == address &&
        other.lat == lat &&
        other.long == long &&
        other.shopKeeperName == shopKeeperName &&
        other.shopKeeperTel == shopKeeperTel &&
        other.shopKeeperMail == shopKeeperMail &&
        other.updateDate == updateDate &&
        other.status == status &&
        other.statusUpdateDate == statusUpdateDate &&
        other.serverStatus == serverStatus &&
        other.serverStatusUpdateDate == serverStatusUpdateDate &&
        other.isProd == isProd &&
        other.isLocked == isLocked &&
        other.promo == promo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        managerMacAddress.hashCode ^
        uuid.hashCode ^
        name.hashCode ^
        tel.hashCode ^
        gescom.hashCode ^
        mail.hashCode ^
        address.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        shopKeeperName.hashCode ^
        shopKeeperTel.hashCode ^
        shopKeeperMail.hashCode ^
        updateDate.hashCode ^
        status.hashCode ^
        statusUpdateDate.hashCode ^
        serverStatus.hashCode ^
        serverStatusUpdateDate.hashCode ^
        isProd.hashCode ^
        isLocked.hashCode ^
        promo.hashCode;
  }
}
