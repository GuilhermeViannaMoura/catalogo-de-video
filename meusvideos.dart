import 'package:flutter/material.dart';
import "home.dart";

import 'dart:convert';

class Tela2 extends StatefulWidget {
  const Tela2({Key? key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Videos"),
        actions: [
          TextButton(
            onPressed: () {
              // Ação do botão "Sair"
              Navigator.pop(context); // Volta para a tela anterior
            },
            child: Text(
              "Sair",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        // Conteúdo da tela
      ),
    );
  }
}
