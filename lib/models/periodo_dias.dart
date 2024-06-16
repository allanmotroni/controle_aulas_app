import 'package:controle_aulas_app/utils/my_date_time.dart';

class PeriodoDias {
  final DateTime dataInicial;
  final DateTime dataFinal;

  const PeriodoDias(this.dataInicial, this.dataFinal);

  List<DateTime> getDias() =>
      MyDateTime.obtemDatasEntre(dataInicial, dataFinal);

  String getDataInicialFormatada() => MyDateTime.format(dataInicial);

  String getDataFinalFormatada() => MyDateTime.format(dataFinal);

  @override
  String toString() =>
      "${dataInicial.day}/${dataInicial.month} - ${dataFinal.day}/${dataFinal.month}";
}
