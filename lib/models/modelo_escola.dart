import 'package:controle_aulas_app/models/escola.dart';

class ModeloEscola {
  final int id;
  final int diaSemana;
  final int escolaId;
  final bool ativo;
  Escola? escola;

  ModeloEscola(this.id, this.diaSemana, this.escolaId, this.ativo,
      {this.escola});

  @override
  String toString() =>
      "id: $id - diaSemana: $diaSemana - escolaId: $escolaId - ativo: $ativo";

  String diaSemanaDescricao() {
    if (diaSemana == 0) {
      return "Domingo";
    }
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
    return "ERROR";
  }

  String diaSemanaDescricaoCurta() {
    if (diaSemana == 0) {
      return "Domingo";
    }
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
    return "ERROR";
  }

  String diaSemanaDescricaoSigla() {
    if (diaSemana == 0) {
      return "Dom";
    }
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
    return "ERROR";
  }
}
