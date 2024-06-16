import 'package:controle_aulas_app/models/dias_da_semana.dart';
import 'package:controle_aulas_app/utils/my_date_time.dart';
import 'package:flutter/material.dart';

class ItemPlanejamentoDia extends StatefulWidget {
  final DateTime dia;
  const ItemPlanejamentoDia({super.key, required this.dia});

  @override
  State<ItemPlanejamentoDia> createState() => _ItemPlanejamentoDiaState();
}

class _ItemPlanejamentoDiaState extends State<ItemPlanejamentoDia> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {}

  //Color? obtemCor() {
  // if (widget.periodoPlanejamento.todosConcluidos()) {
  //   return Colors.greenAccent;
  // } else if (widget.periodoPlanejamento.parcialmenteConcluido()) {
  //   return Colors.amber;
  // }
  // return null;
  //}

  @override
  Widget build(BuildContext context) {
    final String title = DiasDaSemana.obtemDiaDaSemana(widget.dia);
    final String subTitle = MyDateTime.format(widget.dia);

    return SingleChildScrollView(
      child: Card(
        //color: obtemCor(),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.work,
                color: Colors.black,
              ),
              title: Text(title),
              subtitle: Text(subTitle),
              onTap: () async {},
              onLongPress: () async {},
              // trailing: PopupMenuButton<SubMenuOpcoes>(
              //   onSelected: (SubMenuOpcoes result) async {
              //     if (result.index == SubMenuOpcoes.alterar.index) {
              //       widget.onAbrirFormulario(
              //           EnumAcaoTela.alterar, widget.oficina);
              //     } else if (result.index == SubMenuOpcoes.excluir.index) {
              //       widget.onAbrirFormulario(
              //           EnumAcaoTela.excluir, widget.oficina);
              //     } else {
              //       widget.onAbrirFormulario(
              //           EnumAcaoTela.consultar, widget.oficina);
              //     }
              //   },
              //   itemBuilder: (BuildContext context) =>
              //       <PopupMenuEntry<SubMenuOpcoes>>[
              //     const PopupMenuItem<SubMenuOpcoes>(
              //       value: SubMenuOpcoes.alterar,
              //       child: SubMenu(
              //         'Editar',
              //         leading: Icon(Icons.edit),
              //         edgeInsetsGeometry: EdgeInsets.all(0.0),
              //       ),
              //     ),
              //     const PopupMenuItem<SubMenuOpcoes>(
              //       value: SubMenuOpcoes.excluir,
              //       child: SubMenu(
              //         'Remover',
              //         leading: Icon(Icons.delete),
              //         edgeInsetsGeometry: EdgeInsets.all(0.0),
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
