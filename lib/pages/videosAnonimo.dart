import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';




class VideosAnonimoPage extends StatefulWidget {
  const VideosAnonimoPage({Key? key});

  @override
  State<VideosAnonimoPage> createState() => _VideosAnonimoPageState();
}

class _VideosAnonimoPageState extends State<VideosAnonimoPage> {
  

  
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