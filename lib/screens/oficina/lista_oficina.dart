import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/providers/oficina_provider.dart';
import 'package:controle_aulas_app/screens/oficina/formulario_oficina.dart';
import 'package:controle_aulas_app/screens/oficina/widgets/item_oficina.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaOficina extends StatefulWidget {
  const ListaOficina({super.key});

  @override
  State<ListaOficina> createState() => _ListaOficinaState();
}

class _ListaOficinaState extends State<ListaOficina> {
  void abrirFormularioOficina(EnumAcaoTela acaoTela, {Oficina? oficina}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormularioOficina(acaoTela, oficina: oficina),
      ),
    );
  }

  @override
  void initState() {
    context.read<OficinaProvider>().carregaAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Oficina"),
      ),
      body: Consumer<OficinaProvider>(
        builder: (context, oficinaProvider, _) {
          return ListView.builder(
            itemCount: oficinaProvider.oficinas.length,
            itemBuilder: (BuildContext context, int index) {
              final Oficina oficina = oficinaProvider.oficinas[index];
              return ItemOficina(
                oficina,
                (acaoTela, oficina) =>
                    abrirFormularioOficina(acaoTela, oficina: oficina),
              );
            },
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
