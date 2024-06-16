import 'package:controle_aulas_app/screens/escola/lista_escola.dart';
import 'package:controle_aulas_app/screens/oficina/lista_oficina.dart';
import 'package:controle_aulas_app/screens/turma/lista_turma.dart';
import 'package:flutter/material.dart';

class CadastroBasico extends StatelessWidget {
  const CadastroBasico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro Básico"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Escola"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaEscola(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text("Oficina"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaOficina(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: const Text("Turma"),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaTurma(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
