import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:controle_aulas_app/models/turma.dart';

class ModeloTurma {
  int id;
  final int modeloOficinaId;
  final int turmaId;
  final bool ativo;
  ModeloOficina? modeloOficina;
  Turma? turma;

  ModeloTurma(this.id, this.modeloOficinaId, this.turmaId, this.ativo,
      {this.modeloOficina, this.turma});
}
