import 'package:flutter/material.dart';
import 'meusvideos.dart'; //Tela2
import 'home.dart';
import 'cadastro.dart'; //Tela3
import 'acessoanonimo.dart'; // Tela4





void main(){
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/home": (context) => Home(), //HOME
      "/tela2": (context) => Tela2(), //meusvideos
      "/tela3": (context) => Tela3(), //cadastro
      "/tela4": (context) => Tela4(), //acessoanonimo
     
      
    },
    title: "Catalogo de Videos",
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}