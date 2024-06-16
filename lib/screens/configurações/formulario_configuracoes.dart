import 'package:controle_aulas_app/utils/alerta.dart';
import 'package:controle_aulas_app/utils/configuracao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class FormularioConfiguracoes extends StatefulWidget {
  const FormularioConfiguracoes({super.key});

  @override
  State<FormularioConfiguracoes> createState() =>
      _FormularioConfiguracoesState();
}

class _FormularioConfiguracoesState extends State<FormularioConfiguracoes> {
  final TextEditingController _duracaoAulaController = TextEditingController();
  final MoneyMaskedTextController _valorHoraAulaController =
      MoneyMaskedTextController(
    decimalSeparator: ',',
    leftSymbol: 'R\$ ',
    thousandSeparator: '.',
  );
  final String _titulo = "Configurações";

  @override
  void initState() {
    buscaConfiguracoes();
    super.initState();
  }

  void buscaConfiguracoes() {
    _duracaoAulaController.text = Configuracao.duracaoAulas.toString();
    _valorHoraAulaController.updateValue(Configuracao.valorHoraAula);
  }

  void confirma() {
    if (validacao()) {
      Configuracao.duracaoAulas = int.parse(_duracaoAulaController.text);
      Configuracao.valorHoraAula = _valorHoraAulaController.numberValue;

      volta();
    } else {
      Alerta(context).erro("Dados inválidos");
    }
  }

  void volta() {
    if (mounted) {
      Navigator.pop(context);
    }
  }

  bool validacao() {
    bool retorno = true;

    if (int.tryParse(_duracaoAulaController.text) == null) {
      retorno = false;
    }
    if (_valorHoraAulaController.numberValue == 0) {
      retorno = false;
    }

    return retorno;
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
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _duracaoAulaController,
                      decoration:
                          const InputDecoration(labelText: 'Duração Aulas'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _valorHoraAulaController,
                      decoration:
                          const InputDecoration(labelText: 'Valor Aulas'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
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
