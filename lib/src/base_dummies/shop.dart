import 'package:models_weebi/src/base/shop_base.dart';
import 'package:models_weebi/src/utils/dates.dart';

class ShopDummy extends ShopAbstract {
  ShopDummy()
      : super(
          id: 1,
          managerMacAddress: 'pierre_entrepot',
          uuid: 'pierre_entrepot',
          name: 'name',
          tel: 'tel',
          mail: 'mail',
          address: 'address',
          lat: 'lat',
          long: 'long',
          shopKeeperName: 'shopKeeperName',
          shopKeeperTel: 'shopKeeperTel',
          shopKeeperMail: 'shopKeeperMail',
          updateDate: WeebiDates.defaultDate,
          status: true,
          statusUpdateDate: WeebiDates.defaultDate,
          serverStatus: true,
          serverStatusUpdateDate: WeebiDates.defaultDate,
          isProd: true,
          isLocked: false,
          promo: 0.0,
        );
}
