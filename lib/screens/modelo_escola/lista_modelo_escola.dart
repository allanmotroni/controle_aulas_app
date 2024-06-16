import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/screens/modelo_escola/formulario_modelo_escola.dart';
import 'package:controle_aulas_app/screens/modelo_escola/widgets/item_modelo_escola.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ListaModeloEscola extends StatefulWidget {
  const ListaModeloEscola({super.key});

  @override
  State<ListaModeloEscola> createState() => _ListaModeloEscolaState();
}

class _ListaModeloEscolaState extends State<ListaModeloEscola> {
  final ModeloEscolaDao _modeloEscolaDao = ModeloEscolaDao();
  List<ModeloEscola> _modeloEscolas = [];

  void abrirFormularioModeloEscola(EnumAcaoTela acaoTela,
      {ModeloEscola? modeloEscola}) async {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                FormularioModeloEscola(acaoTela, modeloEscola: modeloEscola),
          ),
        )
        .then(
          (onValue) => refresh(),
        );
  }

  void carregar() {
    _modeloEscolaDao.lista().then((modeloEscolas) => {
          setState(() {
            _modeloEscolas = modeloEscolas;
          })
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modelo Escolas"),
      ),
      body: ListView.builder(
        itemCount: _modeloEscolas.length,
        itemBuilder: (BuildContext context, int index) {
          final ModeloEscola modeloEscola = _modeloEscolas[index];
          return ItemModeloEscola(
            modeloEscola,
            (acaoTela, escola) => abrirFormularioModeloEscola(acaoTela,
                modeloEscola: modeloEscola),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioModeloEscola(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
