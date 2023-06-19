import 'package:intl/intl.dart';

class UtilFormat {
  static String formatPrice(int price) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return currencyFormatter.format(price);
  }
}
