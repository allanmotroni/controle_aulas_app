import 'package:controle_aulas_app/database/dao/planejamento_dao.dart';
import 'package:controle_aulas_app/models/periodo_dias.dart';
import 'package:controle_aulas_app/models/periodo_planejamento.dart';
import 'package:controle_aulas_app/models/planejamento.dart';
import 'package:controle_aulas_app/screens/planejamento_semana/widgets/item_planejamento_semana.dart';
import 'package:controle_aulas_app/utils/my_date_time.dart';
import 'package:flutter/material.dart';

class ListaPlanejamentoSemana extends StatefulWidget {
  final DateTime dataFiltro;
  const ListaPlanejamentoSemana(this.dataFiltro, {super.key});

  @override
  State<ListaPlanejamentoSemana> createState() =>
      _ListaPlanejamentoSemanaState();
}

class _ListaPlanejamentoSemanaState extends State<ListaPlanejamentoSemana> {
  String? _title;
  final PlanejamentoDao _planejamentoDao = PlanejamentoDao();
  final List<PeriodoPlanejamento> _listaPeriodoPlanejamento = [];

  @override
  void initState() {
    _title = "${widget.dataFiltro.month}/${widget.dataFiltro.year}";
    var listaPeriodoDias = MyDateTime.obtemListaSemanas(
        widget.dataFiltro.year, widget.dataFiltro.month);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      carregaPeriodoPlanejamento(listaPeriodoDias);
    });
  }

  Future carregaPeriodoPlanejamento(List<PeriodoDias> listaPeriodoDias) async {
    for (var periodoDias in listaPeriodoDias) {
      final List<Planejamento>? planejamentos = await _planejamentoDao
          .obterPorPeriodo(periodoDias.dataInicial, periodoDias.dataFinal);

      PeriodoPlanejamento periodoPlanejamento = PeriodoPlanejamento(
          periodoDias: periodoDias, planejamentos: planejamentos ?? []);

      _listaPeriodoPlanejamento.add(periodoPlanejamento);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title ?? ""),
      ),
      body: ListView.builder(
        itemCount: _listaPeriodoPlanejamento.length,
        itemBuilder: (BuildContext context, int index) {
          final PeriodoPlanejamento periodoPlanejamento =
              _listaPeriodoPlanejamento[index];
          return ItemPlanejamentoSemana(periodoPlanejamento);
        },
      ),
    );
  }
}
