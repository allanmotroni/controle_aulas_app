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

  static String diaSemanaDescricao(int diaSemana) {
    if (diaSemana == 1) {
      return "Segunda-Feira";
    }
    if (diaSemana == 2) {
      return "Terça-Feira";
    }
    if (diaSemana == 3) {
      return "Quarta-Feira";
    }
    if (diaSemana == 4) {
      return "Quinta-Feira";
    }
    if (diaSemana == 5) {
      return "Sexta-Feira";
    }
    if (diaSemana == 6) {
      return "Sábado";
    }
    if (diaSemana == 7) {
      return "Domingo";
    }
    return "ERROR";
  }

  static String diaSemanaDescricaoCurta(int diaSemana) {
    if (diaSemana == 1) {
      return "Segunda";
    }
    if (diaSemana == 2) {
      return "Terça";
    }
    if (diaSemana == 3) {
      return "Quarta";
    }
    if (diaSemana == 4) {
      return "Quinta";
    }
    if (diaSemana == 5) {
      return "Sexta";
    }
    if (diaSemana == 6) {
      return "Sábado";
    }
    if (diaSemana == 7) {
      return "Domingo";
    }
    return "ERROR";
  }

  static String diaSemanaDescricaoSigla(int diaSemana) {
    if (diaSemana == 1) {
      return "Seg";
    }
    if (diaSemana == 2) {
      return "Ter";
    }
    if (diaSemana == 3) {
      return "Qua";
    }
    if (diaSemana == 4) {
      return "Qui";
    }
    if (diaSemana == 5) {
      return "Sex";
    }
    if (diaSemana == 6) {
      return "Sab";
    }
    if (diaSemana == 7) {
      return "Dom";
    }
    return "ERROR";
  }
}
