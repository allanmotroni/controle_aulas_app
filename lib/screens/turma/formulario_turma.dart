import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:controle_aulas_app/services/turma_service.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class FormularioTurma extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final Turma? turma;

  const FormularioTurma(this.acaoTela, {super.key, this.turma});

  @override
  State<FormularioTurma> createState() => _FormularioTurmaState();
}

class _FormularioTurmaState extends State<FormularioTurma> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;

  final TurmaDao _turmaDao = TurmaDao();
  final TurmaService _turmaService = TurmaService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      _nomeController.text = widget.turma!.nome;
      _observacaoController.text = widget.turma!.observacao ?? "";
      _ativo = widget.turma!.ativo;
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
      if (await _turmaService.naoPossuiDependenciaAsync(widget.turma!.id)) {
        await excluiAsync();
      }
    }
  }

  Turma cria() {
    final String nome = _nomeController.text;
    final String observacao = _observacaoController.text;
    final bool ativo = _ativo;
    return Turma(widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.turma!.id,
        nome, ativo,
        observacao: observacao);
  }

  Future<void> incluiAsync() async {
    if (validacao()) {
      final Turma turma = cria();
      await _turmaDao.inclui(turma);
      volta();
    }
  }

  Future<void> alteraAsync() async {
    if (validacao()) {
      final Turma turma = cria();
      await _turmaDao.altera(turma);
      volta();
    }
  }

  Future<void> excluiAsync() async {
    if (widget.turma!.id > 0) {
      await _turmaDao.exclui(widget.turma!.id);
      volta();
    }
  }

  bool validacao() {
    bool retorno = true;
    if (_nomeController.text.isEmpty) {
      retorno = false;
    }

    return retorno;
  }

  void ativoChanged(bool value) {
    setState(() {
      _ativo = value;
    });
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
                  child: TextField(
                    controller: _nomeController,
                    enabled: _camposAtivos,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    maxLines: 3,
                    controller: _observacaoController,
                    enabled: _camposAtivos,
                    decoration: const InputDecoration(labelText: 'Observação'),
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
