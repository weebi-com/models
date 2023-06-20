import 'dart:convert';
import 'package:models_weebi/utils.dart';
import 'package:models_base/common.dart' show Address, ContactAbstract;
import 'package:models_weebi/src/models/tristate.dart';

class ContactWeebi extends ContactAbstract {
  final String shopId;
  String get shopUuid => shopId;
  final TriState isWoman;
  final String category;
  final DateTime? creationDate;
  final Address address; // ? make this a list

  // several tel number, consider also making a list of them
  // would be nice to differentiate the ones to use for whatsapp
  // -> make a dedicated class
  // -> also take time thinking on how you register the number
  // so that whatsapp number is ALWAYS compatible
  ContactWeebi({
    required final int id,
    required String firstName,
    required this.shopId,
    required String lastName,
    required this.creationDate,
    required DateTime? updateDate,
    required DateTime? statusUpdateDate,
    required bool status,
    required this.address,
    this.isWoman = TriState.unknown,
    this.category = '',
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

  String get sharableText {
    final sb = StringBuffer()
      ..writeln('prenom : $firstName')
      ..writeln('nom : $lastName')
      ..writeln('tel : $tel');
    return sb.toString();
  }

  static final dummy = ContactWeebi(
    id: 0,
    shopId: 'dummy',
    firstName: 'inconnu',
    lastName: 'John Doe',
    address: Address.addressEmpty,
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    statusUpdateDate: WeebiDates.defaultDate,
    status: true,
    isWoman: TriState.unknown,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'firstName': firstName,
      'lastName': lastName,
      'address': address.toMap(),
      'tel': tel,
      'mail': mail,
      'avatar': avatar,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'updateDate': updateDate?.millisecondsSinceEpoch,
      'statusUpdateDate': statusUpdateDate?.millisecondsSinceEpoch,
      'status': status,
      'overdraft': overdraft,
      'category': category,
      'isWoman': isWoman.toString(),
    };
  }

  @override
  String toJson() => json.encode(toMap());

  factory ContactWeebi.fromMap(Map<String, dynamic> map) {
    return ContactWeebi(
      id: map['id'],
      shopId: map['shopId'] ?? 'no_shopId', // really ??
      firstName: map['firstName'],
      lastName: map['lastName'],
      address: Address.fromMap(map['address']),
      tel: map['tel'],
      mail: map['mail'],
      avatar: map['avatar'],
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.fromMillisecondsSinceEpoch(map['updateDate']),
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.fromMillisecondsSinceEpoch(map['statusUpdateDate']),
      status: map['status'],
      overdraft: map['overdraft'],
      category: map['category'],
      isWoman: TriState.tryParse(map['isWoman'] as String),
    );
  }
  factory ContactWeebi.fromJson(String source) =>
      ContactWeebi.fromMap(json.decode(source));

  ContactWeebi copyWith({
    int? id,
    String? shopId,
    String? firstName,
    String? lastName,
    Address? address,
    DateTime? creationDate,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
    TriState? isWoman,
    String? category,
    String? qrcode,
    String? tel,
    String? mail,
    String? avatar,
    int? overdraft,
    int? milkMonthQuota,
    String? pointCollecte,
  }) {
    return ContactWeebi(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      creationDate: creationDate ?? this.creationDate,
      updateDate: updateDate ?? this.updateDate,
      statusUpdateDate: statusUpdateDate ?? this.statusUpdateDate,
      status: status ?? this.status,
      tel: tel ?? this.tel,
      mail: mail ?? this.mail,
      avatar: avatar ?? this.avatar,
      overdraft: overdraft ?? this.overdraft,
      category: category ?? this.category,
      isWoman: isWoman ?? this.isWoman,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactWeebi &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode {
    return id.hashCode ^ category.hashCode ^ isWoman.hashCode;
  }
}
