import 'package:flutter/material.dart';
import 'login.dart';
import 'dart:convert';


class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController _emailController = TextEditingController(); //Email
  TextEditingController _senhaController = TextEditingController(); //senha
  TextEditingController _nomeController = TextEditingController(); //Nome
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Nome
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 500,
                  child: TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              ),
            ),
            //Email
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 500,
                  child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              ),

            //Senha
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 500,
                child: TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
              ),
              ),
            // Botao Cadastrar
            ),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String senha = _senhaController.text;
                String nome = _nomeController.text;

                // Printando na tela só para fim de teste, depois que o banco de dado tiver feito, tem que implementar a adicao ao BD
                print("Nome: $nome");
                print("Email: $email");
                print("Senha: $senha");
                //Volta para tela HOME
                Navigator.pushNamed(context, "/login");
                
              },
              child: Text("Cadastar"),
            ),
          ],
        ),
      ),
    );
  }
}