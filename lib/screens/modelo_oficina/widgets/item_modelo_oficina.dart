import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:controle_aulas_app/screens/modelo_oficina/formulario_modelo_oficina.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemModeloOficina extends StatefulWidget {
  ModeloOficina modeloOficina;
  final Function(EnumAcaoTela, ModeloOficina) onAbrirFormulario;

  ItemModeloOficina(this.modeloOficina, this.onAbrirFormulario, {super.key});

  @override
  State<ItemModeloOficina> createState() => _ItemModeloOficinaState();
}

class _ItemModeloOficinaState extends State<ItemModeloOficina> {
  final ModeloOficinaDao _modeloOficinaDao = ModeloOficinaDao();

  void abrirFormularioModeloOficina() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioModeloOficina(
                EnumAcaoTela.consultar,
                modeloOficina: widget.modeloOficina),
          ),
        )
        .then((value) => refresh());
  }

  void refresh() {
    carrega();
  }

  void carrega() {
    _modeloOficinaDao.obterPorId(widget.modeloOficina.id).then((modeloOficina) {
      if (modeloOficina != null) {
        setState(() {
          widget.modeloOficina = modeloOficina;
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
              title: Text(widget.modeloOficina.oficina == null
                  ? widget.modeloOficina.oficinaId.toString()
                  : widget.modeloOficina.oficina!.nome),
              subtitle: Text(
                  "${widget.modeloOficina.modeloEscola!.diaSemanaDescricao()} - ${widget.modeloOficina.duracao}h\n${widget.modeloOficina.modeloEscola!.escola!.nome}\n${widget.modeloOficina.valorFormatado()}/h"),
              onTap: () async {
                abrirFormularioModeloOficina();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  EnumAcaoTela enumAcaoTela = EnumAcaoTela.consultar;
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    enumAcaoTela = EnumAcaoTela.alterar;
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    enumAcaoTela = EnumAcaoTela.excluir;
                  }

                  widget.onAbrirFormulario(enumAcaoTela, widget.modeloOficina);
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
