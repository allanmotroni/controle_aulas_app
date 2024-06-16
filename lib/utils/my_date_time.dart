import 'package:controle_aulas_app/models/periodo_dias.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDateTime {
  static DateTime? stringData(String data) {
    List<String> lista = data.split('/').toList();
    if (lista.length == 3) {
      final DateTime dateTime = DateTime(
          int.parse(lista[2]), int.parse(lista[1]), int.parse(lista[0]));
      return dateTime;
    }
    return null;
  }

  static Future<DateTime?> abreDataPicker(BuildContext context,
      {int firstDateInDays = 3650, int lastDateInDays = 1}) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: firstDateInDays)),
      lastDate: DateTime.now().add(
        Duration(days: lastDateInDays),
      ),
    );
  }

  static List<DateTime> obtemDatasEntre(
      DateTime dataInicial, DateTime dataFinal) {
    List<DateTime> retorno = [];
    DateTime actualDate = dataInicial;
    while (actualDate.isBefore(dataFinal) ||
        actualDate.isAtSameMomentAs(dataFinal)) {
      retorno.add(actualDate);
      actualDate = actualDate.add(const Duration(days: 1));
    }

    return retorno;
  }

  static List<PeriodoDias> obtemListaSemanas(int ano, int mes) {
    DateTime dataAtual = DateTime(ano, mes, 1);
    DateTime dataInicial = DateTime(ano, mes, 1);
    final List<PeriodoDias> listaPeriodoDias = [];

    while (dataAtual.month == mes && dataAtual.year == ano) {
      if (dataAtual.weekday == DateTime.sunday) {
        listaPeriodoDias.add(PeriodoDias(dataInicial, dataAtual));
        dataInicial = dataAtual.add(const Duration(days: 1));
      }

      dataAtual = dataAtual.add(const Duration(days: 1));
    }

    return listaPeriodoDias;
  }

  static String format(DateTime date, {String format = 'dd/MM/yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String obtemDiaDaSemana(DateTime date) {
    return "";
  }
}
