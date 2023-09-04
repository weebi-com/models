class Tristate {
  final String _state;
  const Tristate._(this._state);

  @override
  String toString() => _state;

  static const Tristate unknown = Tristate._('unknown');
  static const Tristate yes = Tristate._('yes');
  static const Tristate no = Tristate._('no');

  static Tristate tryParse(String val) {
    switch (val) {
      case 'unknown':
        return Tristate.unknown;
      case 'yes':
        return Tristate.yes;
      case 'no':
        return Tristate.no;
      default:
        print('$val is not a valid Tristate');
        return Tristate.unknown;
    }
  }

  static String string(Tristate val) {
    if (val == Tristate.unknown) {
      return 'unknown';
    } else if (val == Tristate.yes) {
      return 'yes';
    } else if (val == Tristate.no) {
      return 'no';
    } else {
      return 'unknown';
    }
  }
}
