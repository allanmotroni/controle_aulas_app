import 'package:controle_aulas_app/models/escola.dart';
import 'package:controle_aulas_app/providers/escola_provider.dart';
import 'package:controle_aulas_app/services/escola_service.dart';
import 'package:controle_aulas_app/utils/utils.dart';
import 'package:controle_aulas_app/utils/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioEscola extends StatefulWidget {
  final EnumAcaoTela acaoTela;
  final Escola? escola;

  const FormularioEscola(this.acaoTela, {super.key, this.escola});

  @override
  State<FormularioEscola> createState() => _FormularioEscolaState();
}

class _FormularioEscolaState extends State<FormularioEscola> {
  late String _titulo;
  late bool _camposAtivos;
  late bool _botaoConfirmarVisivel;
  final EscolaService _escolaService = EscolaService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();
  bool _ativo = true;

  void preencheDados() {
    if (widget.acaoTela != EnumAcaoTela.incluir) {
      _nomeController.text = widget.escola!.nome;
      _observacaoController.text = widget.escola!.observacao ?? "";
      _ativo = widget.escola!.ativo;
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
      if (await _escolaService.naoPossuiDependenciaAsync(widget.escola!.id)) {
        await excluiAsync();
      }
    }
  }

  Escola criaEscola() {
    final String nome = _nomeController.text;
    final String observacao = _observacaoController.text;
    final bool ativo = _ativo;
    return Escola(
        widget.acaoTela == EnumAcaoTela.incluir ? 0 : widget.escola!.id,
        nome,
        ativo,
        observacao: observacao);
  }

  Future<void> incluiAsync() async {
    if (validacao()) {
      final Escola escola = criaEscola();
      await context.read<EscolaProvider>().incluiAsync(escola);
      volta();
    }
  }

  Future<void> alteraAsync() async {
    if (validacao()) {
      final Escola escola = criaEscola();
      await context.read<EscolaProvider>().alteraAsync(escola);
      volta();
    }
  }

  Future<void> excluiAsync() async {
    if (widget.escola!.id > 0) {
      await context.read<EscolaProvider>().excluiAsync(widget.escola!);
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
