// live with typo mistake
class PaiementType {
  final String _paiementType;
  const PaiementType._(this._paiementType);

  @override
  String toString() => _paiementType;

  static const PaiementType cash = PaiementType._('cash');
  static const PaiementType mobileMoney = PaiementType._('mobileMoney');
  static const PaiementType nope = PaiementType._('nope');
  static const PaiementType goods = PaiementType._('goods');
  static const PaiementType cheque = PaiementType._('cheque');
  static const PaiementType cb = PaiementType._('cb');
  static const PaiementType unknown = PaiementType._('');

  static List<PaiementType> allPaiementTypes = [
    cash,
    nope,
    mobileMoney,
    // cb, // * not visibile yet
    // cheque, // * not visibile yet
  ];

  static PaiementType tryParse(String val) {
    switch (val) {
      case 'cash':
        return PaiementType.cash;
      case 'mobileMoney':
        return PaiementType.mobileMoney;
      case 'goods':
        return PaiementType.goods;
      case 'cheque':
        return PaiementType.cheque;
      case 'cb':
        return PaiementType.cb;
      case 'nope':
        return PaiementType.nope;
      case '':
        return PaiementType.unknown;
      default:
        print('$val is not a valid paiementType');
        return PaiementType.unknown;
    }
  }

  String get paiementString {
    if (_paiementType == PaiementType.nope.toString()) {
      return 'À crédit';
    } else if (_paiementType == PaiementType.mobileMoney.toString()) {
      return 'Mobile Money';
    } else if (_paiementType == PaiementType.cheque.toString()) {
      return 'Chèque';
    } else if (_paiementType == PaiementType.goods.toString()) {
      return 'Biens';
    } else if (_paiementType == PaiementType.cash.toString()) {
      return 'Cash';
    } else if (_paiementType == PaiementType.cb.toString()) {
      return 'Carte Bancaire';
    } else {
      return 'Inconnu';
    }
  }
}
