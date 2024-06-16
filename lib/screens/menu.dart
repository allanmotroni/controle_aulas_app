import 'package:controle_aulas_app/screens/planejamento_semana/lista_planejamento_semana.dart';
import 'package:controle_aulas_app/screens/cadastro.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                child: const Text("Cadastro"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Cadastro(),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                child: const Text("Planejamento Semana"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ListaPlanejamentoSemana(DateTime.now()),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
