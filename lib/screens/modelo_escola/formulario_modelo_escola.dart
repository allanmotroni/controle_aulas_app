import 'package:controle_aulas_app/models/dia_da_semana.dart';
import 'package:controle_aulas_app/models/dias_da_semana.dart';
import 'package:controle_aulas_app/models/escola.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/providers/dropdown_escola_provider.dart';
import 'package:controle_aulas_app/providers/escola_provider.dart';
import 'package:controle_aulas_app/providers/modelo_escola_provider.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioModeloEscola extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final ModeloEscola? modeloEscola;

  const FormularioModeloEscola(this.acaoTela, {super.key, this.modeloEscola});

  @override
  State<FormularioModeloEscola> createState() => _FormularioModeloEscolaState();
}

class _FormularioModeloEscolaState extends State<FormularioModeloEscola> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;

  final List<DiaDaSemana> _diasDaSemana = DiasDaSemana.list();

  int diaDaSemanaIdSelecionado = DateTime.now().weekday;
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      diaDaSemanaIdSelecionado = widget.modeloEscola!.diaSemana;
      _ativo = widget.modeloEscola!.ativo;
    }
  }

  void travaCampos() {
    _camposAtivos = widget.acaoTela != EnumAcaoTela.consultar &&
        widget.acaoTela != EnumAcaoTela.excluir;
  }

  void volta() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> confirmaAsync() async {
    if (widget.acaoTela == EnumAcaoTela.incluir) {
      await incluiAsync();
    } else if (widget.acaoTela == EnumAcaoTela.alterar) {
      await alteraAsync();
    } else if (widget.acaoTela == EnumAcaoTela.excluir) {
      await excluiAsync();
    }
  }

  ModeloEscola cria() {
    final bool ativo = _ativo;
    return ModeloEscola(
        widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.modeloEscola!.id,
        diaDaSemanaIdSelecionado,
        context.read<DropdownEscolaProvider>().selecionado,
        ativo);
  }

  Future<void> incluiAsync() async {
    if (validacao()) {
      final ModeloEscola model = cria();
      await context.read<ModeloEscolaProvider>().incluiAsync(model);
      volta();
    }
  }

  Future<void> alteraAsync() async {
    if (validacao()) {
      final ModeloEscola model = cria();
      await context.read<ModeloEscolaProvider>().alteraAsync(model);
      volta();
    }
  }

  Future<void> excluiAsync() async {
    if (widget.modeloEscola!.id > 0) {
      await context
          .read<ModeloEscolaProvider>()
          .excluiAsync(widget.modeloEscola!);
      volta();
    }
  }

  bool validacao() {
    bool retorno = true;

    if (context.read<DropdownEscolaProvider>().selecionado == 0) {
      retorno = false;
    }
    if (diaDaSemanaIdSelecionado == 0) {
      retorno = false;
    }

    return retorno;
  }

  void ativoChanged(bool value) {
    setState(() {
      _ativo = value;
    });
  }

  void diaDaSemanaIdChanged(int? diaDaSemanaId) {
    if (diaDaSemanaId != null) {
      setState(() {
        diaDaSemanaIdSelecionado = diaDaSemanaId;
      });
    }
  }

  void escolaIdChanged(int? escolaId) {
    context.read<DropdownEscolaProvider>().selecionado = escolaId!;
  }

  @override
  void initState() {
    _titulo = Utils.obterDescricaoAcaoTela(widget.acaoTela);
    _botaoConfirmarVisivel = widget.acaoTela != EnumAcaoTela.consultar;
    preencheDados();
    travaCampos();
    carregaEscolasAsync();
    super.initState();
  }

  Future<void> carregaEscolasAsync() async {
    await context.read<EscolaProvider>().carregaAsync(ativos: true);
  }

  @override
  Widget build(BuildContext context) {
    var escolas = context.watch<EscolaProvider>().escolas;
    var selecionado = context.watch<DropdownEscolaProvider>().selecionado;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titulo),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<int>(
                    key: UniqueKey(),
                    isDense: false,
                    value: selecionado == 0 ? null : selecionado,
                    items: escolas.isEmpty
                        ? null
                        : escolas.map((Escola escola) {
                            return DropdownMenuItem<int>(
                              value: escola.id,
                              child: Text(escola.nome),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? escolaIdChanged : null,
                    decoration: const InputDecoration(labelText: 'Escola'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<int>(
                    key: UniqueKey(),
                    value: diaDaSemanaIdSelecionado,
                    items: _diasDaSemana.isEmpty
                        ? null
                        : _diasDaSemana.map((DiaDaSemana diaDaSemana) {
                            return DropdownMenuItem<int>(
                              value: diaDaSemana.id,
                              child: Text(diaDaSemana.descricao),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? diaDaSemanaIdChanged : null,
                    decoration:
                        const InputDecoration(labelText: 'Dia da Semana'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Switch(
                    value: _ativo,
                    activeColor: const Color.fromARGB(255, 3, 82, 6),
                    onChanged: _camposAtivos ? ativoChanged : null,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: _botaoConfirmarVisivel,
                  child: ElevatedButton(
                    onPressed: () async => confirmaAsync(),
                    child: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
