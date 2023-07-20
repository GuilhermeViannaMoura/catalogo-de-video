import 'package:flutter/material.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import '../components/myVideoList.dart';

class MeusVideosPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  static const routeName = "/meusVideos";
  
  MeusVideosPage({Key? key, this.usuarioLogado}) : super(key: key);

  @override
  State<MeusVideosPage> createState() => _MeusVideosPageState();
}


class _MeusVideosPageState extends State<MeusVideosPage> {
  final List<Video> listaDeVideos = [
    Video(
      title: "Vídeo 1",
      description: "Descrição do Vídeo 1",
      type: 1,
      ageRestriction: "Livre",
      durationMinutes: 3,
      releaseDate: "01/01/2023",
      thumbnailImageId: "Ação",
      idUsuario: 1
    ),
    Video(
      title: "Vídeo 2",
      description: "Descrição do Vídeo 2",
      type: 0,
      ageRestriction: "Livre",
      durationMinutes: 5,
      releaseDate: "01/01/2023",
      thumbnailImageId: "Terror",
      idUsuario: 1
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
        actions: [
          TextButton(
            onPressed: () {
              //Navigator.pushNamed(context, AdicionarVideoPage.routeName);
            },
            child: Text(
              "Adicionar Video",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Volta para a tela anterior
            },
            child: Text(
              "Sair",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: AccordionPage(videos: listaDeVideos, usuario: widget.usuarioLogado!),
    );
  }
}

