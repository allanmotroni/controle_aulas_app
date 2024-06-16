import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:controle_aulas_app/screens/modelo_oficina/formulario_modelo_oficina.dart';
import 'package:controle_aulas_app/screens/modelo_oficina/widgets/item_modelo_oficina.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ListaModeloOficina extends StatefulWidget {
  const ListaModeloOficina({super.key});

  @override
  State<ListaModeloOficina> createState() => _ListaModeloOficinaState();
}

class _ListaModeloOficinaState extends State<ListaModeloOficina> {
  final ModeloOficinaDao _modeloOficinaDao = ModeloOficinaDao();
  List<ModeloOficina> _modeloOficinas = [];

  void abrirFormularioModeloOficina(EnumAcaoTela acaoTela,
      {ModeloOficina? modeloOficina}) async {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                FormularioModeloOficina(acaoTela, modeloOficina: modeloOficina),
          ),
        )
        .then(
          (onValue) => refresh(),
        );
  }

  void carregar() {
    _modeloOficinaDao.lista().then((modeloOficinas) => {
          setState(() {
            _modeloOficinas = modeloOficinas;
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
        title: const Text("Modelo Oficinas"),
      ),
      body: ListView.builder(
        itemCount: _modeloOficinas.length,
        itemBuilder: (BuildContext context, int index) {
          final ModeloOficina modeloOficina = _modeloOficinas[index];
          return ItemModeloOficina(
            modeloOficina,
            (acaoTela, oficina) => abrirFormularioModeloOficina(acaoTela,
                modeloOficina: modeloOficina),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioModeloOficina(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
