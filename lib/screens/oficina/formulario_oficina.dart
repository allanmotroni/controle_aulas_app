import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:controle_aulas_app/services/oficina_service.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';

class FormularioOficina extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final Oficina? oficina;

  const FormularioOficina(this.acaoTela, {super.key, this.oficina});

  @override
  State<FormularioOficina> createState() => _FormularioOficinaState();
}

class _FormularioOficinaState extends State<FormularioOficina> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;

  final OficinaDao _oficinaDao = OficinaDao();
  final OficinaService _oficinaService = OficinaService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      _nomeController.text = widget.oficina!.nome;
      _observacaoController.text = widget.oficina!.observacao ?? "";
      _ativo = widget.oficina!.ativo;
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
      if (await _oficinaService.naoPossuiDependenciaAsync(widget.oficina!.id)) {
        await excluiAsync();
      }
    }
  }

  Oficina cria() {
    final String nome = _nomeController.text;
    final String observacao = _observacaoController.text;
    final bool ativo = _ativo;
    return Oficina(
        widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.oficina!.id,
        nome,
        ativo,
        observacao: observacao);
  }

  Future<void> incluiAsync() async {
    if (validacao()) {
      final Oficina oficina = cria();
      await _oficinaDao.inclui(oficina);
      volta();
    }
  }

  Future<void> alteraAsync() async {
    if (validacao()) {
      final Oficina oficina = cria();
      await _oficinaDao.altera(oficina);
      volta();
    }
  }

  Future<void> excluiAsync() async {
    if (widget.oficina!.id > 0) {
      await _oficinaDao.exclui(widget.oficina!.id);
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
