library environment;

class Environment {
  final String _env;
  const Environment._(this._env);
  const Environment.custom(this._env);

  static const Environment normal = Environment._('normal');
  static const Environment ldb = Environment._('ldb');
  static const Environment celerity = Environment._('celerity');
  static const Environment reset = Environment._('reset');
  static const Environment test = Environment._('test');
  static const Environment unknown = Environment._('unknown');

  @override
  String toString() => _env;

  static Environment tryParse(String val) {
    switch (val) {
      case 'ldb':
        return Environment.ldb;
      case 'reset':
        return Environment.reset;
      case 'celerity':
        return Environment.celerity;
      case 'normal':
        return Environment.normal;
      default:
        print('$val is not a valid Environment');
        return Environment.unknown;
    }
  }
}
