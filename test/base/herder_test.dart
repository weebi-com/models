import 'dart:convert';
import 'package:models_weebi/src/base_dummies/herder.dart';
import 'package:models_weebi/utils.dart';
import 'package:test/test.dart';

void main() {
  test('herder', () {
    final _json = HerderDummy().toJson();
    final Map<String, dynamic> map = (json.decode(_json));
    expect(map['id'] == 1, isTrue);
    expect(map['id'] == 1, isTrue);
    expect(map['bidon'] == 1, isTrue);
    expect(map['firstName'] == 'super', isTrue);
    expect(map['lastName'] == 'éleveur', isTrue);
    expect(
        map['updateDate'] == WeebiDates.defaultDate.toIso8601String(), isTrue);
    expect(map['statusUpdateDate'] == WeebiDates.defaultDate.toIso8601String(),
        isTrue);
    expect(map['status'] == true, isTrue);
    expect(map['tel'] == 'tel', isTrue);
    expect(map['mail'] == 'mail', isTrue);
    expect(map['address'] == 'address', isTrue);
    expect(map['avatar'] == 'avatar', isTrue);
    expect(map['overdraft'] == 0, isTrue);
    expect(map['milkMonthQuota'] == 0, isTrue);
    expect(map['area'] == 'area', isTrue);
    expect(map['bank'] == 'bank', isTrue);
    expect(map['category'] == 'category', isTrue);
    expect(map['qrcode'] == 'qrcode', isTrue);
    expect(map['identity'] == 'identity', isTrue);
    expect(map['isWoman'] == true, isTrue);
    expect(map['carteNFC'] == 'carteNFC', isTrue);
    expect(map['pointCollecte'] == 'pointCollecte', isTrue);
  });
}
