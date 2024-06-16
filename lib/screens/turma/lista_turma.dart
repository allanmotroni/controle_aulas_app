import 'package:controle_aulas_app/models/turma.dart';
import 'package:controle_aulas_app/providers/turma_provider.dart';
import 'package:controle_aulas_app/screens/turma/formulario_turma.dart';
import 'package:controle_aulas_app/screens/turma/widgets/item_turma.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaTurma extends StatefulWidget {
  const ListaTurma({super.key});

  @override
  State<ListaTurma> createState() => _ListaTurmaState();
}

class _ListaTurmaState extends State<ListaTurma> {
  void abrirFormularioTurma(EnumAcaoTela acaoTela, {Turma? turma}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormularioTurma(acaoTela, turma: turma),
      ),
    );
  }

  @override
  void initState() {
    context.read<TurmaProvider>().carregaAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Turma"),
      ),
      body: Consumer<TurmaProvider>(
        builder: (context, turmaProvider, _) {
          return ListView.builder(
            itemCount: turmaProvider.turmas.length,
            itemBuilder: (BuildContext context, int index) {
              final Turma turma = turmaProvider.turmas[index];
              return ItemTurma(
                turma,
                (acaoTela, turma) =>
                    abrirFormularioTurma(acaoTela, turma: turma),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioTurma(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
