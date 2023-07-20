import 'package:flutter/material.dart';
import 'pages/videosLogado.dart'; //Tela2
import 'pages/login.dart';
import 'pages/cadastro.dart'; //Tela3
import 'pages/videosAnonimo.dart'; // Tela4
import 'pages/meusVideos.dart';





void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/login": (context) => LoginPage(), // pagina de login
      "/homeAuth": (context) => VideosAuthPage(), // pagina de videos estando logado
      "/cadastro": (context) => CadastroPage(), // pagina de cadastro
      "/homeAnon": (context) => VideosAnonimoPage(), // pagina de videos com acesso anônimo
      "/meusVideos": (context) => MeusVideosPage() // pagina dos videos de um usuario
     
      
    },
    title: "Catalogo de Videos",
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}