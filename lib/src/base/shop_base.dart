import 'dart:convert';

import 'package:mobx/mobx.dart';

abstract class ShopAbstract {
  final int id;
  final String managerMacAddress;
  final String uuid;
  final String name;
  final String tel;
  final String mail;
  final String address;
  final String lat;
  final String long;
  final String shopKeeperName;
  final String shopKeeperTel;
  final String shopKeeperMail;
  final DateTime updateDate;
  @observable
  final bool status;
  final DateTime statusUpdateDate;
  final bool serverStatus;
  final DateTime serverStatusUpdateDate;
  final bool isProd;
  final bool isLocked;
  final double promo;

  ShopAbstract({
    required this.id,
    required this.managerMacAddress,
    required this.uuid,
    required this.name,
    required this.updateDate,
    required this.status,
    required this.statusUpdateDate,
    required this.serverStatus,
    required this.serverStatusUpdateDate,
    required this.isProd,
    required this.isLocked,
    required this.promo,
    this.tel = '',
    this.mail = '',
    this.address = '',
    this.lat = '',
    this.long = '',
    this.shopKeeperName = '',
    this.shopKeeperTel = '',
    this.shopKeeperMail = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'managerMacAddress': managerMacAddress,
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

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Shop(id: $id, managerMacAddress: $managerMacAddress, uuid: $uuid, name: $name, tel: $tel, mail: $mail, address: $address, lat: $lat, long: $long, shopKeeperName: $shopKeeperName, shopKeeperTel: $shopKeeperTel, shopKeeperMail: $shopKeeperMail, updateDate: $updateDate, status: $status, statusUpdateDate: $statusUpdateDate, serverStatus: $serverStatus, serverStatusUpdateDate: $serverStatusUpdateDate, isProd: $isProd, isLocked: $isLocked, promo: $promo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopAbstract &&
        other.id == id &&
        other.managerMacAddress == managerMacAddress &&
        other.uuid == uuid &&
        other.name == name &&
        other.tel == tel &&
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
