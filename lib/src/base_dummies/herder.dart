import 'package:models_weebi/src/base/herder_base.dart';
import 'package:models_weebi/src/utils/dates.dart';

class HerderDummy extends HerderAbstract {
  HerderDummy()
      : super(
          id: 1,
          bidon: 1,
          firstName: 'super',
          lastName: 'éleveur',
          updateDate: WeebiDates.defaultDate,
          statusUpdateDate: WeebiDates.defaultDate,
          status: true,
          tel: 'tel',
          mail: 'mail',
          address: 'address',
          avatar: 'avatar',
          overdraft: 0,
          milkMonthQuota: 0,
          area: 'area',
          bank: 'bank',
          category: 'category',
          qrcode: 'qrcode',
          identity: 'identity',
          isWoman: true,
          carteNFC: 'carteNFC',
          pointCollecte: 'pointCollecte',
        );
}
