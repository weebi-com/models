class TriState {
  final String _state;
  const TriState._(this._state);

  @override
  String toString() => _state;

  static const TriState unknown = TriState._('unknown');
  static const TriState yes = TriState._('yes');
  static const TriState no = TriState._('no');

  static TriState tryParse(String val) {
    switch (val) {
      case 'unknown':
        return TriState.unknown;
      case 'yes':
        return TriState.yes;
      case 'no':
        return TriState.no;
      default:
        print('$val is not a valid Tristate');
        return TriState.unknown;
    }
  }

  static String string(TriState val) {
    if (val == TriState.unknown) {
      return 'unknown';
    } else if (val == TriState.yes) {
      return 'yes';
    } else if (val == TriState.no) {
      return 'no';
    } else {
      return 'unknown';
    }
  }
}
