import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/screens/modelo_escola/formulario_modelo_escola.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemModeloEscola extends StatefulWidget {
  ModeloEscola modeloEscola;
  final Function(EnumAcaoTela, ModeloEscola) onAbrirFormulario;

  ItemModeloEscola(this.modeloEscola, this.onAbrirFormulario, {super.key});

  @override
  State<ItemModeloEscola> createState() => _ItemModeloEscolaState();
}

class _ItemModeloEscolaState extends State<ItemModeloEscola> {
  final ModeloEscolaDao _modeloEscolaDao = ModeloEscolaDao();

  void abrirFormularioModeloEscola() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioModeloEscola(EnumAcaoTela.consultar,
                modeloEscola: widget.modeloEscola),
          ),
        )
        .then((value) => refresh());
  }

  void refresh() {
    carrega();
  }

  void carrega() {
    _modeloEscolaDao.obterPorId(widget.modeloEscola.id).then((modeloEscola) {
      if (modeloEscola != null) {
        setState(() {
          widget.modeloEscola = modeloEscola;
        });
      }
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.schema_outlined,
                color: Colors.orange[900],
              ),
              title: Text(widget.modeloEscola.escola == null
                  ? widget.modeloEscola.escolaId.toString()
                  : widget.modeloEscola.escola!.nome),
              subtitle: Text(widget.modeloEscola.diaSemanaDescricao()),
              onTap: () async {
                abrirFormularioModeloEscola();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  EnumAcaoTela enumAcaoTela = EnumAcaoTela.consultar;
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    enumAcaoTela = EnumAcaoTela.alterar;
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    enumAcaoTela = EnumAcaoTela.excluir;
                  }

                  widget.onAbrirFormulario(enumAcaoTela, widget.modeloEscola);
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
