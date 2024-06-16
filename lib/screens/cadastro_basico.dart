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
          ListTile(
            title: const Text("Escola"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaEscola(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Oficina"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ListaOficina(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Turma"),
            onTap: () {
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
