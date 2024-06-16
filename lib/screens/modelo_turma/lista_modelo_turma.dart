import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:controle_aulas_app/screens/modelo_turma/formulario_modelo_turma.dart';
import 'package:controle_aulas_app/screens/modelo_turma/widgets/item_modelo_turma.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ListaModeloTurma extends StatefulWidget {
  const ListaModeloTurma({super.key});

  @override
  State<ListaModeloTurma> createState() => _ListaModeloTurmaState();
}

class _ListaModeloTurmaState extends State<ListaModeloTurma> {
  final ModeloTurmaDao _modeloTurmaDao = ModeloTurmaDao();
  List<ModeloTurma> _modeloTurmas = [];

  void abrirFormularioModeloTurma(EnumAcaoTela acaoTela,
      {ModeloTurma? modeloTurma}) async {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                FormularioModeloTurma(acaoTela, modeloTurma: modeloTurma),
          ),
        )
        .then(
          (onValue) => refresh(),
        );
  }

  void refresh() {
    carregar();
  }

  void carregar() {
    _modeloTurmaDao.lista().then((modeloTurmas) => {
          setState(() {
            _modeloTurmas = modeloTurmas;
          })
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modelo Turmas"),
      ),
      body: ListView.builder(
        itemCount: _modeloTurmas.length,
        itemBuilder: (BuildContext context, int index) {
          final ModeloTurma modeloTurma = _modeloTurmas[index];
          return ItemModeloTurma(
            modeloTurma,
            (acaoTela, turma) =>
                abrirFormularioModeloTurma(acaoTela, modeloTurma: modeloTurma),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioModeloTurma(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
