import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:controle_aulas_app/screens/turma/formulario_turma.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemTurma extends StatefulWidget {
  Turma turma;
  final Function(EnumAcaoTela, Turma) onAbrirFormulario;

  ItemTurma(this.turma, this.onAbrirFormulario, {super.key});

  @override
  State<ItemTurma> createState() => _ItemTurmaState();
}

class _ItemTurmaState extends State<ItemTurma> {
  final TurmaDao _turmaDao = TurmaDao();

  void abrirFormularioTurma() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) =>
                FormularioTurma(EnumAcaoTela.consultar, turma: widget.turma),
          ),
        )
        .then((value) => refresh());
  }

  void refresh() {
    carregaTurma();
  }

  void carregaTurma() {
    _turmaDao.obterPorId(widget.turma.id).then((turma) {
      if (turma != null) {
        setState(() {
          widget.turma = turma;
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
              leading: const Icon(
                Icons.group,
                color: Colors.red,
              ),
              title: Text(widget.turma.nome),
              onTap: () async {
                abrirFormularioTurma();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.alterar, widget.turma);
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.excluir, widget.turma);
                  } else {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.consultar, widget.turma);
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
