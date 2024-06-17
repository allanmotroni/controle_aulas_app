import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:controle_aulas_app/utils/my_date_time.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class FormularioModeloTurma extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final ModeloTurma? modeloTurma;

  const FormularioModeloTurma(this.acaoTela, {super.key, this.modeloTurma});

  @override
  State<FormularioModeloTurma> createState() => _FormularioModeloTurmaState();
}

class _FormularioModeloTurmaState extends State<FormularioModeloTurma> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;

  final ModeloTurmaDao _modeloTurmaDao = ModeloTurmaDao();
  final ModeloOficinaDao _modeloOficinaDao = ModeloOficinaDao();
  final TurmaDao _turmaDao = TurmaDao();
  List<Turma> _turmas = [];
  List<ModeloOficina> _modeloOficinas = [];

  int _modeloOficinaIdSelecionado = 0;
  int _turmaIdSelecionado = 0;
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      _modeloOficinaIdSelecionado = widget.modeloTurma!.modeloOficinaId;
      _turmaIdSelecionado = widget.modeloTurma!.turmaId;
      _ativo = widget.modeloTurma!.ativo;
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

  void confirma() {
    if (widget.acaoTela == EnumAcaoTela.incluir) {
      inclui();
    } else if (widget.acaoTela == EnumAcaoTela.alterar) {
      altera();
    } else if (widget.acaoTela == EnumAcaoTela.excluir) {
      exclui();
    }
  }

  ModeloTurma cria() {
    final bool ativo = _ativo;
    return ModeloTurma(
        widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.modeloTurma!.id,
        _modeloOficinaIdSelecionado,
        _turmaIdSelecionado,
        ativo);
  }

  void inclui() async {
    if (validacao()) {
      final ModeloTurma model = cria();
      await _modeloTurmaDao.inclui(model);
      volta();
    }
  }

  void altera() async {
    if (validacao()) {
      final ModeloTurma model = cria();
      await _modeloTurmaDao.altera(model);
      volta();
    }
  }

  void exclui() async {
    if (widget.modeloTurma!.id > 0) {
      await _modeloTurmaDao.exclui(widget.modeloTurma!.id);
      volta();
    }
  }

  bool validacao() {
    bool retorno = true;

    if (_turmaIdSelecionado == 0) {
      retorno = false;
    }
    if (_modeloOficinaIdSelecionado == 0) {
      retorno = false;
    }
    return retorno;
  }

  void ativoChanged(bool value) {
    setState(() {
      _ativo = value;
    });
  }

  void modeloOficinaIdChanged(int? oficinaId) {
    if (oficinaId != null) {
      setState(() {
        _modeloOficinaIdSelecionado = oficinaId;
      });
    }
  }

  void turmaIdChanged(int? turmaId) {
    if (turmaId != null) {
      setState(() {
        _turmaIdSelecionado = turmaId;
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

    carregaTurmas();
    carregaModeloOficinas();
  }

  void carregaTurmas() {
    _turmaDao.lista().then((turmas) {
      setState(() {
        _turmas = turmas;
        if (_turmaIdSelecionado == 0) {
          _turmaIdSelecionado = _turmas[0].id;
        }
      });
    });
  }

  void carregaModeloOficinas() {
    _modeloOficinaDao.lista().then((modeloOficinas) {
      setState(() {
        _modeloOficinas = modeloOficinas;
        if (_modeloOficinaIdSelecionado == 0) {
          _modeloOficinaIdSelecionado = _modeloOficinas[0].id;
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
                    value: _modeloOficinaIdSelecionado,
                    items: _modeloOficinas.isEmpty
                        ? null
                        : _modeloOficinas.map((ModeloOficina modeloOficina) {
                            return DropdownMenuItem<int>(
                              value: modeloOficina.id,
                              child: Text(
                                  "${modeloOficina.oficina!.nome} - ${MyDateTime.diaSemanaDescricao(modeloOficina.modeloEscola!.diaSemana)} - ${modeloOficina.duracao}h\n${modeloOficina.modeloEscola!.escola!.nome}\n${modeloOficina.valorFormatado()}/h"),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? modeloOficinaIdChanged : null,
                    decoration:
                        const InputDecoration(labelText: 'Modelo Oficina'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: DropdownButtonFormField<int>(
                    key: UniqueKey(),
                    value: _turmaIdSelecionado,
                    items: _turmas.isEmpty
                        ? null
                        : _turmas.map((Turma turma) {
                            return DropdownMenuItem<int>(
                              value: turma.id,
                              child: Text(turma.nome),
                            );
                          }).toList(),
                    onChanged: _camposAtivos ? turmaIdChanged : null,
                    decoration: const InputDecoration(labelText: 'Turma'),
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
