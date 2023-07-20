import 'dart:math';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _emailController = TextEditingController(); //Email
  TextEditingController _senhaController = TextEditingController(); //senha

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nome App"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
            // Botao Entrar
            ),
            ElevatedButton(
              onPressed: () {
                String email = _emailController.text;
                String senha = _senhaController.text;

                // Printando na tela só para fim de teste, depois que o banco de dado tiver feito, tem que implementar a autenticacao
                print("Email: $email");
                print("Senha: $senha");
                //Vai para tela Meus videos
                Navigator.pushNamed(context, "/tela2");
              },
              child: Text("Entrar"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Acesso anonimo
                TextButton(
                  onPressed: () {
                    //Ainda nao faz nada
                    print("Acesso Anônimo pressionado");
                    //Vai para tela de acesso anonimo
                    Navigator.pushNamed(context, "/tela4");
                  },
                  child: Text("Acesso Anônimo"),
                ),
                SizedBox(width: 20), // Espaço entre os botões
                //Cadastrar
                TextButton(
                  onPressed: () {
                    // Ação do botão "Cadastrar"
                    print("Cadastrar pressionado");
                    //Vai para tela de Cadastro
                    Navigator.pushNamed(context,"/tela3");
                  },
                  child: Text("Cadastrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
