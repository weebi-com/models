import 'dart:convert';

import 'package:models_weebi/src/base_dummies/shop.dart';
import 'package:models_weebi/utils.dart';
import 'package:test/test.dart';

void main() {
  test('shop', () {
    // print(ShopDummy().uuid);
    final _json = ShopDummy().toJson();
    final Map<String, dynamic> shopMap = (json.decode(_json));
    expect(shopMap['id'] == 1, isTrue);
    expect(shopMap['managerMacAddress'] == 'pierre_entrepot', isTrue);
    expect(shopMap['uuid'] == 'pierre_entrepot', isTrue);
    expect(shopMap['name'] == 'name', isTrue);
    expect(shopMap['tel'] == 'tel', isTrue);
    expect(shopMap['mail'] == 'mail', isTrue);
    expect(shopMap['address'] == 'address', isTrue);
    expect(shopMap['lat'] == 'lat', isTrue);
    expect(shopMap['long'] == 'long', isTrue);
    expect(shopMap['shopKeeperName'] == 'shopKeeperName', isTrue);
    expect(shopMap['shopKeeperTel'] == 'shopKeeperTel', isTrue);
    expect(shopMap['shopKeeperMail'] == 'shopKeeperMail', isTrue);
    expect(shopMap['updateDate'] == WeebiDates.defaultDate.toIso8601String(),
        isTrue);
    expect(shopMap['status'] == true, isTrue);
    expect(
        shopMap['statusUpdateDate'] == WeebiDates.defaultDate.toIso8601String(),
        isTrue);
    expect(shopMap['serverStatus'] == true, isTrue);
    expect(
        shopMap['serverStatusUpdateDate'] ==
            WeebiDates.defaultDate.toIso8601String(),
        isTrue);
    expect(shopMap['isProd'] == true, isTrue);
    expect(shopMap['isLocked'] == false, isTrue);
    expect(shopMap['promo'] == 0.0, isTrue);
  });
}
