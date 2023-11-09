import 'dart:convert';

abstract class ContactAbstract {
  final int id;
  final String firstName;
  final String lastName;
  final String tel;
  final String mail;
  final String avatar; // photo
  final DateTime? updateDate; // if Contact info are updated, keep date here
  final DateTime? statusUpdateDate; // if status changes, update date here
  final bool status;
  final int overdraft; // clientBalance limit

  const ContactAbstract({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.tel = '',
    this.mail = '',
    this.avatar = '',
    this.overdraft = 0,
    this.status = true,
    this.updateDate,
    this.statusUpdateDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'tel': tel,
      'mail': mail,
      'avatar': avatar,
      'updateDate': updateDate?.millisecondsSinceEpoch,
      'statusUpdateDate': statusUpdateDate?.millisecondsSinceEpoch,
      'status': status,
      'overdraft': overdraft,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactAbstract &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.tel == tel &&
        other.mail == mail &&
        other.avatar == avatar &&
        other.updateDate == updateDate &&
        other.statusUpdateDate == statusUpdateDate &&
        other.status == status &&
        other.overdraft == overdraft;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        tel.hashCode ^
        mail.hashCode ^
        avatar.hashCode ^
        updateDate.hashCode ^
        statusUpdateDate.hashCode ^
        status.hashCode ^
        overdraft.hashCode;
  }
}
