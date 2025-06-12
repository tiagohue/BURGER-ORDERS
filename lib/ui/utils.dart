import 'package:intl/intl.dart';

class Utils {
  static String formatReal(double valor) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valor);
  }

  static String formatDate(String date) {
    final parts = date.split("-");
    return "${parts[2]}/${parts[1]}";
  }
}
