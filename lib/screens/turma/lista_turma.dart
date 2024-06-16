import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:controle_aulas_app/screens/turma/formulario_turma.dart';
import 'package:controle_aulas_app/screens/turma/widgets/item_turma.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ListaTurma extends StatefulWidget {
  const ListaTurma({super.key});

  @override
  State<ListaTurma> createState() => _ListaTurmaState();
}

class _ListaTurmaState extends State<ListaTurma> {
  final TurmaDao _turmaDao = TurmaDao();
  List<Turma> _turmas = [];

  void abrirFormularioTurma(EnumAcaoTela acaoTela, {Turma? turma}) async {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioTurma(acaoTela, turma: turma),
          ),
        )
        .then(
          (onValue) => refresh(),
        );
  }

  void carregarTurmas() {
    _turmaDao.lista().then((turmas) => {
          setState(() {
            _turmas = turmas;
          })
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    carregarTurmas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Turma"),
      ),
      body: ListView.builder(
        itemCount: _turmas.length,
        itemBuilder: (BuildContext context, int index) {
          final Turma turma = _turmas[index];
          return ItemTurma(
            turma,
            (acaoTela, turma) => abrirFormularioTurma(acaoTela, turma: turma),
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
