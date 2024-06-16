import 'package:controle_aulas_app/screens/cadastro_basico.dart';
import 'package:controle_aulas_app/screens/cadastro_modelos.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatelessWidget {
  const Cadastro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Cadastro Básico'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CadastroBasico(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Cadastro Modelos'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CadastroModelos(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
