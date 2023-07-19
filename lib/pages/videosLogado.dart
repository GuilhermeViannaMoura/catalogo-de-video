import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';

class VideosAuthPage extends StatefulWidget {
  const VideosAuthPage({Key? key});

  @override
  State<VideosAuthPage> createState() => _VideosAuthPageState();
}

class _VideosAuthPageState extends State<VideosAuthPage> {

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
