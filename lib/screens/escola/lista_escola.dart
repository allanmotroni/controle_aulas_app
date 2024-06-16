import 'package:controle_aulas_app/models/escola.dart';
import 'package:controle_aulas_app/providers/escola_provider.dart';
import 'package:controle_aulas_app/screens/escola/formulario_escola.dart';
import 'package:controle_aulas_app/screens/escola/widgets/item_escola.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaEscola extends StatefulWidget {
  const ListaEscola({super.key});

  @override
  State<ListaEscola> createState() => _ListaEscolaState();
}

class _ListaEscolaState extends State<ListaEscola> {
  void abrirFormularioEscola(EnumAcaoTela acaoTela, {Escola? escola}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FormularioEscola(acaoTela, escola: escola),
      ),
    );
  }

  @override
  void initState() {
    context.read<EscolaProvider>().carregaAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escola"),
      ),
      body: Consumer<EscolaProvider>(
        builder: (BuildContext context, EscolaProvider escolaProvider,
            Widget? child) {
          return ListView.builder(
            itemCount: escolaProvider.escolas.length,
            itemBuilder: (BuildContext context, int index) {
              final Escola escola = escolaProvider.escolas[index];
              return ItemEscola(
                escola,
                (acaoTela, escola) =>
                    abrirFormularioEscola(acaoTela, escola: escola),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioEscola(EnumAcaoTela.incluir);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
