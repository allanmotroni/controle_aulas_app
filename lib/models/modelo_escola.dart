import 'package:controle_aulas_app/models/escola.dart';

class ModeloEscola {
  int id;
  final int diaSemana;
  final int escolaId;
  final bool ativo;
  Escola? escola;

  ModeloEscola(this.id, this.diaSemana, this.escolaId, this.ativo,
      {this.escola});

  @override
  String toString() =>
      "id: $id - diaSemana: $diaSemana - escolaId: $escolaId - ativo: $ativo";
}
