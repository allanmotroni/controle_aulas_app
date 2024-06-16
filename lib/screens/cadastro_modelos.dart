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
          ElevatedButton(
            child: const Text("Escola"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaModeloEscola(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text("Oficina"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaModeloOficina(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text("Turma"),
            onPressed: () {
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
