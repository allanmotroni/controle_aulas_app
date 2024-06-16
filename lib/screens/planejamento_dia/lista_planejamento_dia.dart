import 'package:controle_aulas_app/models/periodo_planejamento.dart';
import 'package:controle_aulas_app/screens/planejamento_dia/widgets/item_planejamento_dia.dart';
import 'package:flutter/material.dart';

class ListaPlanejamentoDia extends StatefulWidget {
  final PeriodoPlanejamento periodoPlanejamento;

  const ListaPlanejamentoDia({super.key, required this.periodoPlanejamento});

  @override
  State<ListaPlanejamentoDia> createState() => _ListaPlanejamentoDiaState();
}

class _ListaPlanejamentoDiaState extends State<ListaPlanejamentoDia> {
  String? _title;

  void abrirFormularioPlanejamentoDia() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title ?? ""),
      ),
      body: ListView.builder(
        itemCount: widget.periodoPlanejamento.periodoDias.getDias().length,
        itemBuilder: (BuildContext context, int index) {
          final DateTime dia =
              widget.periodoPlanejamento.periodoDias.getDias()[index];

          return ItemPlanejamentoDia(dia: dia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          abrirFormularioPlanejamentoDia();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
