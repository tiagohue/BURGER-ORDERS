import 'package:intl/intl.dart';

class Utils {
  static String formatReal(double valor) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
  }
}
