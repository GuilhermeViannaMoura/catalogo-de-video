import 'package:flutter/material.dart';
import 'package:videos/classes/usuario.dart';
import 'package:videos/pages/meusVideos.dart';
import '../components/videoList.dart';

class VideosLogadoPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  static const routeName = "/homeLogado";

  VideosLogadoPage({Key? key, this.usuarioLogado}) : super(key: key);

  @override
  State<VideosLogadoPage> createState() => _VideosLogadoPageState();
}

class _VideosLogadoPageState extends State<VideosLogadoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
        automaticallyImplyLeading: false,
        actions: [TextButton(
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => MeusVideosPage(usuarioLogado: widget.usuarioLogado)));
            },
            child: Text(
              "Meus Videos",
              style: TextStyle(color: Colors.white),
            ),
          ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: VideoList(),
      ),
    );
  }
}
