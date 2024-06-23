import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/providers/dropdown_escola_provider.dart';
import 'package:controle_aulas_app/providers/modelo_escola_provider.dart';
import 'package:controle_aulas_app/screens/modelo_escola/formulario_modelo_escola.dart';
import 'package:controle_aulas_app/screens/modelo_escola/widgets/item_modelo_escola.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaModeloEscola extends StatefulWidget {
  const ListaModeloEscola({super.key});

  @override
  State<ListaModeloEscola> createState() => _ListaModeloEscolaState();
}

class _ListaModeloEscolaState extends State<ListaModeloEscola> {
  void abrirFormularioModeloEscola(EnumAcaoTela acaoTela,
      {ModeloEscola? modeloEscola}) async {
    if (acaoTela != EnumAcaoTela.incluir) {
      context.read<DropdownEscolaProvider>().selecionado =
          modeloEscola!.escolaId;
    } else {
      context.read<DropdownEscolaProvider>().selecionado = 0;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            FormularioModeloEscola(acaoTela, modeloEscola: modeloEscola),
      ),
    );
  }

  @override
  void initState() {
    context.read<ModeloEscolaProvider>().carregaAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Modelo Escolas"),
      ),
      body: Consumer<ModeloEscolaProvider>(
        builder: (BuildContext context,
            ModeloEscolaProvider modeloEscolaProvider, _) {
          return ListView.builder(
            itemCount: modeloEscolaProvider.modeloEscolas.length,
            itemBuilder: (BuildContext context, int index) {
              final ModeloEscola modeloEscola =
                  modeloEscolaProvider.modeloEscolas[index];
              return ItemModeloEscola(
                modeloEscola,
                (acaoTela, escola) => abrirFormularioModeloEscola(acaoTela,
                    modeloEscola: modeloEscola),
              );
            },
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
