import 'package:intl/intl.dart' as intl;

final numFormat = intl.NumberFormat('###,###,###,###.##', 'fr'); // no , only .
final csvFormatter = intl.DateFormat('dd-MM-yyyy-HH-mm-ss');

final dateFormatter = intl.DateFormat('dd/MM/y', 'fr');

final dateTimeFormatter = intl.DateFormat('dd/MM/yyyy HH:mm:ss', 'fr');

final dateYearMonthFormatter = intl.DateFormat('yMMMM', 'fr');
final yearFormatter = intl.DateFormat('y', 'fr');
final monthFormatter = intl.DateFormat('MMMM', 'fr');
final dayInMonthFormatter = intl.DateFormat('d', 'fr');
final eeeDdateFormatter = intl.DateFormat('EEEEd', 'fr');
final normalDateFormat = intl.DateFormat('yMMMMEEEEd', 'fr');

final hms = intl.DateFormat('Hms', 'fr');
final hourMinuteFormatter = intl.DateFormat('Hm', 'fr');
