import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);
  }
}