import 'package:controle_aulas_app/screens/modelo_escola/lista_modelo_escola.dart';
import 'package:controle_aulas_app/screens/modelo_oficina/lista_modelo_oficina.dart';
import 'package:controle_aulas_app/screens/modelo_turma/lista_modelo_turma.dart';
import 'package:flutter/material.dart';

class CadastroModelos extends StatelessWidget {
  const CadastroModelos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro Modelos"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Escola"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaModeloEscola(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Oficina"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaModeloOficina(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Turma"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaModeloTurma(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
