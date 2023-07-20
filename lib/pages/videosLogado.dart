import 'package:flutter/material.dart';
import 'package:videos/classes/usuario.dart';
import '../components/videoList.dart';
import '../classes/video.dart';

class VideosLogadoPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  static const routeName = "/homeLogado";

  VideosLogadoPage({Key? key, this.usuarioLogado}) : super(key: key);

  @override
  State<VideosLogadoPage> createState() => _VideosLogadoPageState();
}

class _VideosLogadoPageState extends State<VideosLogadoPage> {
  final List<Video> listaDeVideos = [
    Video(
      title: "Vídeo 1",
      description: "Descrição do Vídeo 1",
      type: 1,
      ageRestriction: "Livre",
      durationMinutes: 2,
      releaseDate: "01/01/2023",
      thumbnailImageId: "1",
      idUsuario: 1
    ),
    Video(
      title: "Vídeo 2",
      description: "Descrição do Vídeo 2",
      type: 0,
      ageRestriction: "18+",
      durationMinutes: 2,
      releaseDate: "15/03/2023",
      thumbnailImageId: "2",
      idUsuario: 1
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
        actions: [TextButton(
            onPressed: () {
              // Ação do botão "Logar"
              Navigator.pushNamed(context, "/meusVideos"); // Volta para a tela anterior
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
        child: VideoList(listaDeVideos),
      ),
    );
  }
}
