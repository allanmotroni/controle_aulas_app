import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/screens/oficina/formulario_oficina.dart';
import 'package:controle_aulas_app/widgets/sub_menu.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemOficina extends StatefulWidget {
  Oficina oficina;
  final Function(EnumAcaoTela, Oficina) onAbrirFormulario;

  ItemOficina(this.oficina, this.onAbrirFormulario, {super.key});

  @override
  State<ItemOficina> createState() => _ItemOficinaState();
}

class _ItemOficinaState extends State<ItemOficina> {
  final OficinaDao _oficinaDao = OficinaDao();

  void abrirFormularioOficina() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => FormularioOficina(EnumAcaoTela.consultar,
                oficina: widget.oficina),
          ),
        )
        .then((value) => refresh());
  }

  void refresh() {
    carregaOficina();
  }

  void carregaOficina() {
    _oficinaDao.obterPorId(widget.oficina.id).then((oficina) {
      if (oficina != null) {
        setState(() {
          widget.oficina = oficina;
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
                Icons.toys,
                color: Colors.blue,
              ),
              title: Text(widget.oficina.nome),
              onTap: () async {
                abrirFormularioOficina();
              },
              trailing: PopupMenuButton<SubMenuOpcoes>(
                onSelected: (SubMenuOpcoes result) async {
                  if (result.index == SubMenuOpcoes.alterar.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.alterar, widget.oficina);
                  } else if (result.index == SubMenuOpcoes.excluir.index) {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.excluir, widget.oficina);
                  } else {
                    widget.onAbrirFormulario(
                        EnumAcaoTela.consultar, widget.oficina);
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
