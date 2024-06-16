class Escola {
  int id;
  final String nome;
  final String? observacao;
  final bool ativo;

  Escola(this.id, this.nome, this.ativo, {this.observacao});

  @override
  String toString() => "id: $id - nome: $nome - ativo: $ativo";
}
