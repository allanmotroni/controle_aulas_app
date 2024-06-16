import 'package:intl/intl.dart';

class Converts {
  static String money(double valor) {
    String retorno =
        NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 2)
            .format(valor);
    return retorno;
  }
}
