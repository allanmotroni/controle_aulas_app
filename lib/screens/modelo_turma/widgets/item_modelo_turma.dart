import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:controle_aulas_app/screens/modelo_turma/formulario_modelo_turma.dart';
import 'package:controle_aulas_app/utils/my_date_time.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemModeloTurma extends StatefulWidget {
  ModeloTurma modeloTurma;
  final Function(EnumAcaoTela, ModeloTurma) onAbrirFormulario;

  ItemModeloTurma(this.modeloTurma, this.onAbrirFormulario, {super.key});

  @override
  State<ItemModeloTurma> createState() => _ItemModeloTurmaState();
}

class _ItemModeloTurmaState extends State<ItemModeloTurma> {
  final ModeloTurmaDao _modeloTurmaDao = ModeloTurmaDao();

  void abrirFormularioModeloTurma() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioModeloTurma(EnumAcaoTela.consultar,
                modeloTurma: widget.modeloTurma),
          ),
        )
        .then((value) => refresh());
  }

  void refresh() {
    carrega();
  }

  void carrega() {
    _modeloTurmaDao.obterPorId(widget.modeloTurma.id).then((modeloTurma) {
      if (modeloTurma != null) {
        setState(() {
          widget.modeloTurma = modeloTurma;
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
              title: Text(widget.modeloTurma.turma == null
                  ? widget.modeloTurma.turmaId.toString()
                  : widget.modeloTurma.turma!.nome),
              subtitle: Text(
                  "${widget.modeloTurma.modeloOficina!.oficina!.nome}\n${MyDateTime.diaSemanaDescricao(widget.modeloTurma.modeloOficina!.modeloEscola!.diaSemana)} - ${widget.modeloTurma.modeloOficina!.duracao}h\n${widget.modeloTurma.modeloOficina!.modeloEscola!.escola!.nome}\n${widget.modeloTurma.modeloOficina!.valorFormatado()}/h"),
              onTap: () async {
                abrirFormularioModeloTurma();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  EnumAcaoTela enumAcaoTela = EnumAcaoTela.consultar;
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    enumAcaoTela = EnumAcaoTela.alterar;
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    enumAcaoTela = EnumAcaoTela.excluir;
                  }

                  widget.onAbrirFormulario(enumAcaoTela, widget.modeloTurma);
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
