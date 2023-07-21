import 'package:flutter/material.dart';
import 'package:videos/controller/db_controller.dart';
import 'package:videos/pages/cadastro.dart';
import 'package:videos/util/video_genero_helper.dart';
import '../classes/video.dart';
import '../classes/genero.dart';
import '../components/videoList.dart';
import '../pages/login.dart';



class VideosAnonimoPage extends StatefulWidget {
  static const routeName = "/homeAnonimo";

  VideosAnonimoPage({Key? key});

  @override
  State<VideosAnonimoPage> createState() => _VideosAnonimoPageState();
}

class _VideosAnonimoPageState extends State<VideosAnonimoPage> {
  late DataBaseController controller;
  List<Video>? videos;
  Map<int,List<Genero>>? infos;
  
  _VideosAnonimoPageState(){
    this.controller = DataBaseController();
  }

  
  void pegarVideos() async{
    controller.getAllVideos().then((data) => 
      setState(() {
        this.videos = data;
      })
    );
  }

  void pegarGeneros() async{
    Future.wait([controller.getAllGeneros(), controller.getAllVideosGeneros()]).then((List values) => setState(() {
        this.infos = getMapGenerosByVideoId(values[0], values[1]);
      }));
  }

  @override
  void initState() {
    super.initState();
    pegarVideos();
    pegarGeneros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatalogoV"),
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
        child: VideoList(videos,infos),
      ),
    );
  } 
}

