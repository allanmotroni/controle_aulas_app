import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/models/dia_da_semana.dart';
import 'package:controle_aulas_app/models/dias_da_semana.dart';
import 'package:controle_aulas_app/models/escola.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

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

  final ModeloEscolaDao _modeloEscolaDao = ModeloEscolaDao();
  final EscolaDao _escolaDao = EscolaDao();
  late List<Escola> _escolas = [];
  final List<DiaDaSemana> _diasDaSemana = DiasDaSemana.list();

  int diaDaSemanaIdSelecionado = DateTime.now().weekday;
  int escolaIdSelecionado = 0;
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      diaDaSemanaIdSelecionado = widget.modeloEscola!.diaSemana;
      escolaIdSelecionado = widget.modeloEscola!.escolaId;
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
        escolaIdSelecionado,
        ativo);
  }

  Future<void> incluiAsync() async {
    if (validacao()) {
      final ModeloEscola model = cria();
      await _modeloEscolaDao.inclui(model);
      volta();
    }
  }

  Future<void> alteraAsync() async {
    if (validacao()) {
      final ModeloEscola model = cria();
      await _modeloEscolaDao.altera(model);
      volta();
    }
  }

  Future<void> excluiAsync() async {
    if (widget.modeloEscola!.id > 0) {
      await _modeloEscolaDao.exclui(widget.modeloEscola!.id);
      volta();
    }
  }

  bool validacao() {
    bool retorno = true;

    if (escolaIdSelecionado == 0) {
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
    if (escolaId != null) {
      setState(() {
        escolaIdSelecionado = escolaId;
      });
    }
  }

  @override
  void initState() {
    setState(() {
      _titulo = Utils.obterDescricaoAcaoTela(widget.acaoTela);
      preencheDados();
      travaCampos();
      _botaoConfirmarVisivel = widget.acaoTela != EnumAcaoTela.consultar;
    });

    super.initState();

    carregaEscolas();
  }

  void carregaEscolas() {
    _escolaDao.lista().then((escolas) {
      setState(() {
        _escolas = escolas;
        if (escolaIdSelecionado == 0) {
          escolaIdSelecionado = _escolas[0].id;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    value: escolaIdSelecionado,
                    items: _escolas.isEmpty
                        ? null
                        : _escolas.map((Escola escola) {
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
