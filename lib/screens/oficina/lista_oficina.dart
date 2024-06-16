import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/screens/oficina/formulario_oficina.dart';
import 'package:controle_aulas_app/screens/oficina/widgets/item_oficina.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ListaOficina extends StatefulWidget {
  const ListaOficina({super.key});

  @override
  State<ListaOficina> createState() => _ListaOficinaState();
}

class _ListaOficinaState extends State<ListaOficina> {
  final OficinaDao _oficinaDao = OficinaDao();
  List<Oficina> _oficinas = [];

  void abrirFormularioOficina(EnumAcaoTela acaoTela, {Oficina? oficina}) async {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioOficina(acaoTela, oficina: oficina),
          ),
        )
        .then(
          (onValue) => refresh(),
        );
  }

  void carregarOficinas() {
    _oficinaDao.lista().then((oficinas) => {
          setState(() {
            _oficinas = oficinas;
          })
        });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    carregarOficinas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oficina"),
      ),
      body: ListView.builder(
        itemCount: _oficinas.length,
        itemBuilder: (BuildContext context, int index) {
          final Oficina oficina = _oficinas[index];
          return ItemOficina(
            oficina,
            (acaoTela, oficina) =>
                abrirFormularioOficina(acaoTela, oficina: oficina),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioOficina(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
