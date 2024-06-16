import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class FormularioModeloOficina extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final ModeloOficina? modeloOficina;

  const FormularioModeloOficina(this.acaoTela, {super.key, this.modeloOficina});

  @override
  State<FormularioModeloOficina> createState() =>
      _FormularioModeloOficinaState();
}

class _FormularioModeloOficinaState extends State<FormularioModeloOficina> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;

  final ModeloOficinaDao _modeloOficinaDao = ModeloOficinaDao();
  final ModeloEscolaDao _modeloEscolaDao = ModeloEscolaDao();
  final OficinaDao _oficinaDao = OficinaDao();
  List<Oficina> _oficinas = [];
  List<ModeloEscola> _modeloEscolas = [];

  int _modeloEscolaIdSelecionado = 0;
  int _oficinaIdSelecionado = 0;
  final TextEditingController _duracaoController = TextEditingController();
  final MoneyMaskedTextController _valorController = MoneyMaskedTextController(
    decimalSeparator: ',',
    leftSymbol: 'R\$ ',
    thousandSeparator: '.',
  );
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      _modeloEscolaIdSelecionado = widget.modeloOficina!.modeloEscolaId;
      _oficinaIdSelecionado = widget.modeloOficina!.oficinaId;
      _duracaoController.text = widget.modeloOficina!.duracao.toString();
      _valorController.updateValue(widget.modeloOficina!.valor);
      _ativo = widget.modeloOficina!.ativo;
    }
  }

  void travaCampos() {
    _camposAtivos = widget.acaoTela != EnumAcaoTela.consultar &&
        widget.acaoTela != EnumAcaoTela.excluir;
  }

  void volta(BuildContext context) {
    Navigator.pop(context);
  }

  void confirma() {
    if (widget.acaoTela == EnumAcaoTela.incluir) {
      inclui();
    } else if (widget.acaoTela == EnumAcaoTela.alterar) {
      altera();
    } else if (widget.acaoTela == EnumAcaoTela.excluir) {
      exclui();
    }
  }

  ModeloOficina cria() {
    final int duracao = int.parse(_duracaoController.text);
    final double valor = _valorController.numberValue;
    final bool ativo = _ativo;
    return ModeloOficina(
        widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.modeloOficina!.id,
        _modeloEscolaIdSelecionado,
        _oficinaIdSelecionado,
        duracao,
        valor,
        ativo);
  }

  void inclui() async {
    if (validacao()) {
      final ModeloOficina model = cria();
      await _modeloOficinaDao.inclui(model);
      volta(context);
    }
  }

  void altera() async {
    if (validacao()) {
      final ModeloOficina model = cria();
      await _modeloOficinaDao.altera(model);
      volta(context);
    }
  }

  void exclui() async {
    if (widget.modeloOficina!.id > 0) {
      await _modeloOficinaDao.exclui(widget.modeloOficina!.id);
      volta(context);
    }
  }

  bool validacao() {
    bool retorno = true;

    if (_oficinaIdSelecionado == 0) {
      retorno = false;
    }
    if (_modeloEscolaIdSelecionado == 0) {
      retorno = false;
    }
    if (int.tryParse(_duracaoController.text) == null) {
      retorno = false;
    }
    if (_valorController.numberValue == 0) {
      retorno = false;
    }

    return retorno;
  }

  void ativoChanged(bool value) {
    setState(() {
      _ativo = value;
    });
  }

  void oficinaIdChanged(int? oficinaId) {
    if (oficinaId != null) {
      setState(() {
        _oficinaIdSelecionado = oficinaId;
      });
    }
  }

  void modeloEscolaIdChanged(int? modeloEscolaId) {
    if (modeloEscolaId != null) {
      setState(() {
        _modeloEscolaIdSelecionado = modeloEscolaId;
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

    carregaOficinas();
    carregaModeloEscolas();
  }

  void carregaOficinas() {
    _oficinaDao.lista().then((oficinas) {
      setState(() {
        _oficinas = oficinas;
        if (_oficinaIdSelecionado == 0) {
          _oficinaIdSelecionado = _oficinas[0].id;
        }
      });
    });
  }

  void carregaModeloEscolas() {
    _modeloEscolaDao.lista().then((modeloEscolas) {
      setState(() {
        _modeloEscolas = modeloEscolas;
        if (_modeloEscolaIdSelecionado == 0) {
          _modeloEscolaIdSelecionado = _modeloEscolas[0].id;
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
                    value: _modeloEscolaIdSelecionado,
                    items: _modeloEscolas.isEmpty
                        ? null
                        : _modeloEscolas.map((ModeloEscola modeloEscola) {
                            return DropdownMenuItem<int>(
                              value: modeloEscola.id,
                              child: Text(
                                  "${modeloEscola.escola!.nome}\n${modeloEscola.diaSemanaDescricao()}"),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? modeloEscolaIdChanged : null,
                    decoration:
                        const InputDecoration(labelText: 'Modelo Escola'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<int>(
                    key: UniqueKey(),
                    value: _oficinaIdSelecionado,
                    items: _oficinas.isEmpty
                        ? null
                        : _oficinas.map((Oficina oficina) {
                            return DropdownMenuItem<int>(
                              value: oficina.id,
                              child: Text(oficina.nome),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? oficinaIdChanged : null,
                    decoration: const InputDecoration(labelText: 'Oficina'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _duracaoController,
                    enabled: _camposAtivos,
                    maxLength: 3,
                    decoration: const InputDecoration(labelText: 'Duração'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _valorController,
                    enabled: _camposAtivos,
                    decoration: const InputDecoration(labelText: 'Valor'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
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
                    onPressed: () => confirma(),
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
