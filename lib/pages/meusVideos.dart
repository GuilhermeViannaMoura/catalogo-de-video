import 'package:flutter/material.dart';
import 'package:videos/pages/videosLogado.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import '../components/myVideoList.dart';
import 'adicionarVideo.dart';
import '../controller/db_controller.dart';

class MeusVideosPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  static const routeName = "/meusVideos";
  
  MeusVideosPage({this.usuarioLogado});

  @override
  State<MeusVideosPage> createState() => _MeusVideosPageState();
}


class _MeusVideosPageState extends State<MeusVideosPage> {
  late DataBaseController controller;
  List<Video>? videosUser;

  _MeusVideosPageState(){
    this.controller = DataBaseController();
  }

  void pegarVideos() async{
    controller.getAllVideos().then((data) =>
      setState(() {
        this.videosUser = userVideos(data!);
      })
    );
  }

  List<Video> userVideos(List<Video> videos){
      List<Video> l = [];
      for(int i = 0; i < videos.length; i++){
        if(videos[i].idUsuario == widget.usuarioLogado!.id){
          l.add(videos[i]);
        }
      }
      return l;
  }

  @override
  void initState() {
    super.initState();
    pegarVideos();
  }

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
              Navigator.pop(context); // Volta para a tela anterior
            },
            child: Text(
              "Sair",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: AccordionPage(videos: videosUser, usuario: widget.usuarioLogado!),
    );
  }
}

