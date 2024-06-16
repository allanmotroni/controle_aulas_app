import 'package:controle_aulas_app/models/periodo_dias.dart';
import 'package:controle_aulas_app/models/planejamento.dart';

class PeriodoPlanejamento {
  final PeriodoDias periodoDias;
  List<Planejamento>? planejamentos = [];

  PeriodoPlanejamento({required this.periodoDias, this.planejamentos});

  // adiciona(Planejamento planejamento) {
  //   if (planejamentos == null) {
  //     planejamentos
  //   }
  //     planejamentos.add(planejamento);
  // }

  adicionaLista(List<Planejamento>? planejamentos) {
    if (planejamentos != null) {
      planejamentos.addAll(planejamentos);
    }
  }

  bool todosConcluidos() {
    return false;
  }

  bool parcialmenteConcluido() {
    return false;
  }
}
