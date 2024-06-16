import 'package:controle_aulas_app/models/dia_da_semana.dart';

class DiasDaSemana {
  static List<DiaDaSemana> list() {
    List<DiaDaSemana> list = [];
    list.addAll([
      DiaDaSemana(DateTime.monday, 'Segunda-Feira'),
      DiaDaSemana(DateTime.tuesday, 'Terça-Feira'),
      DiaDaSemana(DateTime.wednesday, 'Quarta-Feira'),
      DiaDaSemana(DateTime.thursday, 'Quinta-Feira'),
      DiaDaSemana(DateTime.friday, 'Sexta-Feira'),
      DiaDaSemana(DateTime.saturday, 'Sábado'),
      DiaDaSemana(DateTime.sunday, 'Domingo'),
    ]);

    return list;
  }

  static String obtemDiaDaSemana(DateTime data) {
    return list().firstWhere((item) => item.id == data.weekday).descricao;
  }
}
