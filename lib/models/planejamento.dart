import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:controle_aulas_app/utils/my_date_time.dart';

class Planejamento {
  final int id;
  final int modeloTurmaId;
  final String data;
  final bool concluido;
  final bool ativo;
  ModeloTurma? modeloTurma;

  Planejamento(
      this.id, this.modeloTurmaId, this.data, this.concluido, this.ativo,
      {this.modeloTurma});

  String dataFormatada() {
    return MyDateTime.format(DateTime.parse(data));
  }

  @override
  String toString() =>
      "id: $id - modeloTurmaId: $modeloTurmaId - data: $data - concluído: $concluido - ativo: $ativo";
}
