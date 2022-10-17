import 'dart:convert';

import 'package:models_base/base.dart' show ShopAbstract;
import 'package:models_base/utils.dart';
import 'package:models_weebi/common.dart' show Address;

// consider adding
// * String appVersionBuildNumber
// * also add String emailResult

class ShopWeebi extends ShopAbstract {
  String gescom;
  String mailUnique;
  final Address? addressComplete;
  final DateTime? promoStart;
  final DateTime? promoEnd;
  String? get shopId => uuid;
  ShopWeebi({
    required int id,
    required String uuid,
    this.mailUnique = '',
    required String name,
    required String tel,
    required bool status,
    required DateTime statusUpdateDate,
    required bool serverStatus,
    required DateTime serverStatusUpdateDate,
    required bool isProd,
    required bool isLocked,
    required DateTime updateDate,
    this.gescom = '',
    this.addressComplete,
    double promo = 0.0,
    this.promoStart,
    this.promoEnd,
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
    mailUnique: '',
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

  static final dummy = ShopWeebi(
    id: 0,
    uuid: 'shopUuid',
    mailUnique: '',
    name: 'Magasin par défaut',
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
    Address? addressComplete,
    String? uuid,
    String? mailUnique,
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
    DateTime? promoStart,
    DateTime? promoEnd,
  }) {
    return ShopWeebi(
      id: id ?? this.id,
      addressComplete: addressComplete ?? this.addressComplete,
      uuid: uuid ?? this.uuid,
      mailUnique: mailUnique ?? this.mailUnique,
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
      promoStart: promoStart ?? this.promoStart,
      promoEnd: promoEnd ?? this.promoEnd,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'addressComplete': addressComplete?.toMap(),
      'mailUnique': mailUnique,
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
      'promoStart': promoStart?.toIso8601String(),
      'promoEnd': promoEnd?.toIso8601String(),
    };
  }

  factory ShopWeebi.fromMap(Map<String, dynamic> map) {
    return ShopWeebi(
      id: map['id'],
      uuid: map['uuid'],
      addressComplete: map['addressComplete'] != null
          ? Address.fromMap(map['addressComplete'])
          : Address.addressEmpty,
      mailUnique: map['mailUnique'],
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
      promo: map['promo'] == null ? 0.0 : (map['promo'] as num).toDouble(),
      promoStart: map['promoStart'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['promoStart']),
      promoEnd: map['promoEnd'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['promoEnd']),
    );
  }
  @override
  String toJson() => json.encode(toMap());

  factory ShopWeebi.fromJson(String source) =>
      ShopWeebi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shop(id: $id, uuid: $uuid, mailUnique: $mailUnique, name: $name, tel: $tel, mail: $mail, address: $address, lat: $lat, long: $long, shopKeeperName: $shopKeeperName, shopKeeperTel: $shopKeeperTel, shopKeeperMail: $shopKeeperMail, updateDate: $updateDate, status: $status, statusUpdateDate: $statusUpdateDate, serverStatus: $serverStatus, serverStatusUpdateDate: $serverStatusUpdateDate, isProd: $isProd, isLocked: $isLocked, promo: $promo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopWeebi &&
        other.gescom == gescom &&
        other.mailUnique == mailUnique &&
        other.uuid == uuid;
  }

  @override
  int get hashCode => gescom.hashCode ^ mailUnique.hashCode ^ uuid.hashCode;
}
