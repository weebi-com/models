import 'package:models_base/common.dart' show Environment;

class EnvironmentWeebi extends Environment {
  @override
  const EnvironmentWeebi(String _env) : super.custom(_env);
  static const EnvironmentWeebi ldb = EnvironmentWeebi('ldb');

  Environment tryParse(String val) {
    switch (val) {
      case 'ldb':
        return EnvironmentWeebi.ldb;
      case 'reset':
        return Environment.reset;
      case 'test':
        return Environment.test;
      case 'celerity':
        return Environment.celerity;
      case 'normal':
        return Environment.normal;
      default:
        print('$val is not a valid EnvWeebi');
        return Environment.unknown;
    }
  }
}
