import 'package:flutter/material.dart';
import "home.dart";

import 'dart:convert';




class Tela4 extends StatefulWidget {
  const Tela4({Key? key});

  @override
  State<Tela4> createState() => _Tela4State();
}

class _Tela4State extends State<Tela4> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Acesso anonimo"),
        actions: [
          TextButton(
            onPressed: () {
              // Ação do botão "Logar"
              Navigator.pop(context); // Volta para a tela anterior
            },
            child: Text(
              "Logar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Ação do botão "Cadastrar"
              Navigator.pushNamed(context, "/tela3"); // Vai para tela de cadastro
            },
            child: Text(
              "Cadastrar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        
      ),
    );
  }
}