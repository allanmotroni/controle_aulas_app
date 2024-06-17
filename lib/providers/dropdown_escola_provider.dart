import 'package:flutter/material.dart';

class DropdownEscolaProvider with ChangeNotifier {
  int _selecionado = 0;
  int get selecionado => _selecionado;

  set selecionado(int novoValor) {
    _selecionado = novoValor;
    notifyListeners();
  }
}
