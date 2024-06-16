import 'package:flutter/material.dart';

class Alerta {
  final BuildContext context;

  Alerta(this.context);

  void _aviso(String texto, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(texto),
        backgroundColor: cor,
      ),
    );
  }

  void erro(String texto) => _aviso(texto, Colors.red);

  void sucesso(String texto) => _aviso(texto, Colors.green);
}
