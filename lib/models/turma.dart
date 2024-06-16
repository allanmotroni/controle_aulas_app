class Turma {
  int id;
  final String nome;
  final String? observacao;
  final bool ativo;

  Turma(this.id, this.nome, this.ativo, {this.observacao});

  @override
  String toString() => "id: $id - nome: $nome - ativo: $ativo";
}
