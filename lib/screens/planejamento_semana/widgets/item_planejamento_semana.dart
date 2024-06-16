import 'package:controle_aulas_app/models/periodo_planejamento.dart';
import 'package:controle_aulas_app/screens/planejamento_dia/lista_planejamento_dia.dart';
import 'package:flutter/material.dart';

class ItemPlanejamentoSemana extends StatefulWidget {
  final PeriodoPlanejamento periodoPlanejamento;

  const ItemPlanejamentoSemana(this.periodoPlanejamento, {super.key});

  @override
  State<ItemPlanejamentoSemana> createState() => _ItemPlanejamentoSemanaState();
}

class _ItemPlanejamentoSemanaState extends State<ItemPlanejamentoSemana> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {}

  Color? obtemCor() {
    if (widget.periodoPlanejamento.todosConcluidos()) {
      return Colors.greenAccent;
    } else if (widget.periodoPlanejamento.parcialmenteConcluido()) {
      return Colors.amber;
    }
    return null;
  }

  void abrirListaPlanejamentoDia() {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ListaPlanejamentoDia(
                periodoPlanejamento: widget.periodoPlanejamento),
          ),
        )
        .then((value) => refresh());
  }

  @override
  Widget build(BuildContext context) {
    final String title =
        "${widget.periodoPlanejamento.periodoDias.getDataInicialFormatada()} - ${widget.periodoPlanejamento.periodoDias.getDataFinalFormatada()}";

    return SingleChildScrollView(
      child: Card(
        color: obtemCor(),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.work,
                color: Colors.black,
              ),
              title: Text(title),
              onTap: () async {
                abrirListaPlanejamentoDia();
              },
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
