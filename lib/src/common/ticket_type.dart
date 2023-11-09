class TicketType {
  final String _ticketType;
  const TicketType._(this._ticketType);

  @override
  String toString() => _ticketType;

  static const TicketType sell = TicketType._('sell');
  static const TicketType sellDeferred = TicketType._('sellDeferred');
  static const TicketType sellCovered = TicketType._('sellCovered');
  static const TicketType spend = TicketType._('spend');
  static const TicketType spendDeferred = TicketType._('spendDeferred');
  static const TicketType spendCovered = TicketType._('spendCovered');
  static const TicketType stockIn = TicketType._('stockIn');
  static const TicketType stockOut = TicketType._('stockOut');
  static const TicketType wage = TicketType._('wage');
  static const TicketType unknown = TicketType._('');

  static const financialTypes = <TicketType>[
    sell,
    sellDeferred,
    sellCovered,
    spend,
    spendDeferred,
    spendCovered,
    // wage, // not available yet
  ];

  static List<TicketType> allTicketTypes = [
    sell,
    sellDeferred,
    sellCovered,
    spend,
    spendDeferred,
    spendCovered,
    stockIn,
    stockOut,
    // wage, // not available yet
  ];

  bool get isShopInput =>
      this == spend || this == spendDeferred || this == stockIn;

  bool get isShopOutput =>
      this == sell || this == sellDeferred || this == stockOut;

  static TicketType tryParse(String val) {
    switch (val) {
      case 'sell':
        return TicketType.sell;
      case 'sellDeferred':
        return TicketType.sellDeferred;
      case 'sellCovered':
        return TicketType.sellCovered;
      case 'spend':
        return TicketType.spend;
      case 'spendCovered':
        return TicketType.spendCovered;
      case 'spendDeferred':
        return TicketType.spendDeferred;
      case 'stockIn':
        return TicketType.stockIn;
      case 'stockOut':
        return TicketType.stockOut;
      case 'wage':
        return TicketType.wage;
      case '':
        return TicketType.unknown;
      default:
        print('$val is not a valid TicketType');
        return TicketType.unknown;
    }
  }

  String get typeString {
    if (_ticketType == TicketType.stockIn.toString()) {
      return 'Entree de stock';
    } else if (_ticketType == TicketType.stockOut.toString()) {
      return 'Sortie de stock';
    } else if (_ticketType == TicketType.sell.toString()) {
      return 'Vente';
    } else if (_ticketType == TicketType.sellCovered.toString()) {
      return 'Versement client';
    } else if (_ticketType == TicketType.sellDeferred.toString()) {
      return 'Vente à crédit';
    } else if (_ticketType == TicketType.spend.toString()) {
      return 'Achat/Dépense';
    } else if (_ticketType == TicketType.spendCovered.toString()) {
      return 'Versement fournisseur';
    } else if (_ticketType == TicketType.spendDeferred.toString()) {
      return 'Achat à crédit'; // KSDE specific 'Achat via compte f'
    } else if (_ticketType == TicketType.wage.toString()) {
      return 'Salaire';
    } else {
      return 'Autre';
    }
  }
}
