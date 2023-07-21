import 'package:flutter/material.dart';
import 'package:videos/pages/login.dart';
import 'package:videos/pages/videosLogado.dart';
import '../classes/usuario.dart';
import '../components/myVideoList.dart';
import 'adicionarVideo.dart';

class MeusVideosPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  static const routeName = "/meusVideos";
  
  MeusVideosPage({this.usuarioLogado});

  @override
  State<MeusVideosPage> createState() => _MeusVideosPageState();
}


class _MeusVideosPageState extends State<MeusVideosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => VideosLogadoPage(usuarioLogado: widget.usuarioLogado)));
            },
            child: Text(
              "Videos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdicionarVideoPage(usuario: widget.usuarioLogado)));
            },
            child: Text(
              "Adicionar Video",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routeName);
            },
            child: Text(
              "Sair",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: AccordionPage(usuario: widget.usuarioLogado!),
    );
  }
}

