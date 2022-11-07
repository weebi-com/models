import 'package:models_base/common.dart' show Environment;

class EnvironmentWeebi extends Environment {
  @override
  const EnvironmentWeebi(String _env) : super.custom(_env);
  static const EnvironmentWeebi ldb = EnvironmentWeebi('ldb');
  static const EnvironmentWeebi normal = EnvironmentWeebi('normal');
  static const EnvironmentWeebi test = EnvironmentWeebi('test');
  static const EnvironmentWeebi sidy = EnvironmentWeebi('sidy');
  static const EnvironmentWeebi unknown = EnvironmentWeebi('unknown');

  EnvironmentWeebi tryParse(String val) {
    switch (val) {
      case 'ldb':
        return EnvironmentWeebi.ldb;
      case 'normal':
        return EnvironmentWeebi.normal;
      case 'sidy':
        return EnvironmentWeebi.sidy;
      case 'test':
        return EnvironmentWeebi.test;
      // case 'reset':
      //   return Environment.reset;
      // case 'celerity':
      //   return Environment.celerity;
      default:
        print('$val is not a valid EnvWeebi');
        return EnvironmentWeebi.unknown;
    }
  }
}
