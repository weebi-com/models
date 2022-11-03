import 'dart:convert';
import 'package:models_base/utils.dart';
import 'package:models_weebi/common.dart' show ContactAbstract, Tristate;

//TODO unit test this model jsonization
class ContactWeebi extends ContactAbstract {
  final String shopId;
  String get shopUuid => shopId;
  final Tristate isWoman;
  final String category;
  final DateTime? creationDate;
  ContactWeebi({
    required final int id,
    required String firstName,
    required this.shopId,
    required String lastName,
    required this.creationDate,
    required DateTime? updateDate,
    required DateTime? statusUpdateDate,
    required bool status,
    this.isWoman = Tristate.unknown,
    this.category = '',
    String tel = '',
    String mail = '',
    String address = '',
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

  // only override if add specific field
  // @override Map<String, dynamic> toMap()

  static final dummy = ContactWeebi(
    id: 0,
    shopId: 'dummy',
    firstName: 'inconnu',
    lastName: 'John Doe',
    creationDate: WeebiDates.defaultDate,
    updateDate: WeebiDates.defaultDate,
    statusUpdateDate: WeebiDates.defaultDate,
    status: true,
    isWoman: Tristate.unknown,
  );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shopId': shopId,
      'firstName': firstName,
      'lastName': lastName,
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
      tel: map['tel'],
      mail: map['mail'],
      address: map['address'],
      avatar: map['avatar'],
      creationDate: map['creationDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['creationDate']),
      updateDate: map['updateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['updateDate']),
      statusUpdateDate: map['statusUpdateDate'] == null
          ? WeebiDates.defaultDate
          : DateTime.parse(map['statusUpdateDate']),
      status: map['status'],
      overdraft: map['overdraft'],
      category: map['category'],
      isWoman: Tristate.tryParse(map['isWoman'] as String),
    );
  }
  factory ContactWeebi.fromJson(String source) =>
      ContactWeebi.fromMap(json.decode(source));

  ContactWeebi copyWith({
    int? id,
    String? shopId,
    String? firstName,
    String? lastName,
    DateTime? creationDate,
    DateTime? updateDate,
    DateTime? statusUpdateDate,
    bool? status,
    Tristate? isWoman,
    String? category,
    String? qrcode,
    String? tel,
    String? mail,
    String? address,
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
