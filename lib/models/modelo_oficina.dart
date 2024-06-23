import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/utils/converts.dart';

class ModeloOficina {
  int id;
  final int modeloEscolaId;
  final int oficinaId;
  final int duracao;
  final double valor;
  final bool ativo;
  ModeloEscola? modeloEscola;
  Oficina? oficina;

  ModeloOficina(this.id, this.modeloEscolaId, this.oficinaId, this.duracao,
      this.valor, this.ativo,
      {this.modeloEscola, this.oficina});

  valorFormatado() => Converts.money(valor);

  @override
  String toString() =>
      "id: $id - modeloEscolaId: $modeloEscolaId - oficinaId: $oficinaId - duração: $duracao - valor: $valor - ativo: $ativo";
}
