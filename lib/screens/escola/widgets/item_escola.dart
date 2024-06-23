import 'package:controle_aulas_app/models/escola.dart';
import 'package:controle_aulas_app/screens/escola/formulario_escola.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class ItemEscola extends StatefulWidget {
  final Escola escola;
  final Function(EnumAcaoTela, Escola) onAbrirFormulario;

  const ItemEscola(this.escola, this.onAbrirFormulario, {super.key});

  @override
  State<ItemEscola> createState() => _ItemEscolaState();
}

class _ItemEscolaState extends State<ItemEscola> {
  void abrirFormularioEscola() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            FormularioEscola(EnumAcaoTela.consultar, escola: widget.escola),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.school_outlined,
                color: Colors.green,
              ),
              title: Text(widget.escola.nome),
              onTap: () async {
                abrirFormularioEscola();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.alterar, widget.escola);
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.excluir, widget.escola);
                  } else {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.consultar, widget.escola);
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SubMenuOpcoes>>[
                  const PopupMenuItem<SubMenuOpcoes>(
                    value: SubMenuOpcoes.alterar,
                    child: SubMenu(
                      'Editar',
                      leading: Icon(Icons.edit),
                      edgeInsetsGeometry: EdgeInsets.all(0.0),
                    ),
                  ),
                  const PopupMenuItem<SubMenuOpcoes>(
                    value: SubMenuOpcoes.excluir,
                    child: SubMenu(
                      'Remover',
                      leading: Icon(Icons.delete),
                      edgeInsetsGeometry: EdgeInsets.all(0.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
