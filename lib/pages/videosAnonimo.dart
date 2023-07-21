import 'package:flutter/material.dart';
import 'package:videos/pages/cadastro.dart';
import '../components/videoList.dart';
import '../pages/login.dart';



class VideosAnonimoPage extends StatefulWidget {
  static const routeName = "/homeAnonimo";

  VideosAnonimoPage();

  @override
  State<VideosAnonimoPage> createState() => _VideosAnonimoPageState();
}

class _VideosAnonimoPageState extends State<VideosAnonimoPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routeName); // Volta para a tela anterior
            },
            child: Text(
              "Logar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, CadastroPage.routeName);
            },
            child: Text(
              "Cadastrar",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: VideoList(),
      ),
    );
  } 
}

