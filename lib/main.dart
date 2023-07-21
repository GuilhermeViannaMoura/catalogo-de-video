import 'package:flutter/material.dart';
import 'pages/videosLogado.dart';
import 'pages/login.dart';
import 'pages/cadastro.dart';
import 'pages/videosAnonimo.dart';
import 'pages/meusVideos.dart';
import 'pages/editarVideo.dart';
import 'pages/adicionarVideo.dart';





void main(){
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      LoginPage.routeName: (context) => LoginPage(), // pagina de login
      CadastroPage.routeName: (context) => CadastroPage(), // pagina de cadastro
      VideosAnonimoPage.routeName: (context) => VideosAnonimoPage(), // pagina de videos com acesso anônimo
      VideosLogadoPage.routeName: (context) => VideosLogadoPage(), // pagina de videos estando logado
      MeusVideosPage.routeName: (context) => MeusVideosPage(), // pagina dos videos de um usuario
      EditarVideoPage.routeName: (context) => EditarVideoPage(), // pagina de edicao de um video
      AdicionarVideoPage.routeName: (context) => AdicionarVideoPage() // 
     
      
    },
    title: "Catalogo de Videos",
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}