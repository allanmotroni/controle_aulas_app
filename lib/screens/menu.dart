import 'dart:io';

import 'package:controle_aulas_app/components/hamburger_menu.dart';
import 'package:controle_aulas_app/components/hamburger_menu_item.dart';
import 'package:controle_aulas_app/screens/cadastro.dart';
import 'package:controle_aulas_app/screens/configura%C3%A7%C3%B5es/formulario_configuracoes.dart';
import 'package:controle_aulas_app/screens/planejamento_semana/lista_planejamento_semana.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      drawer: HamburgerMenu(
        widgets: [
          const HamburgerMenuItem(title: 'Cadastro', widget: Cadastro()),
          const Divider(),
          HamburgerMenuItem(
              title: 'Planejamento Semana',
              widget: ListaPlanejamentoSemana(
                dataFiltro: DateTime.now(),
              )),
          const Divider(),
          const HamburgerMenuItem(
              title: 'Configurações', widget: FormularioConfiguracoes()),
          const Divider(),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              //SystemNavigator.pop();
              exit(0);
            },
          ),
          const Divider(),
        ],
      ),
      body: const Text(''),
    );
  }
}
