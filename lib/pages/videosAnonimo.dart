import 'package:flutter/material.dart';
import 'package:videos/controller/db_controller.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import '../components/videoList.dart';



class VideosAnonimoPage extends StatefulWidget {
  static const routeName = "/homeAnonimo";

  VideosAnonimoPage({Key? key});

  @override
  State<VideosAnonimoPage> createState() => _VideosAnonimoPageState();
}

class _VideosAnonimoPageState extends State<VideosAnonimoPage> {
  final List<Video> listaDeVideos = [];
  late DataBaseController controller;
  late List<Video>? videos;
  
  _VideosAnonimoPageState(){
    this.controller = DataBaseController();
  }

  void adicionarVideos() async {
    // Crie alguns objetos Video com os dados dos vídeos que deseja adicionar
    Video video1 = Video(
      title: "Vídeo 1",
      description: "Descrição do Vídeo 1",
      type: 0,
      ageRestriction: "Livre",
      durationMinutes: 150,
      thumbnailImageId: "id_da_imagem_1",
      releaseDate: "2023-01-01",
      idUsuario: 1,
    );

    Video video2 = Video(
      title: "Vídeo 2",
      description: "Descrição do Vídeo 2",
      type: 1,
      ageRestriction: "18+",
      durationMinutes: 105,
      thumbnailImageId: "id_da_imagem_2",
      releaseDate: "2023-03-15",
      idUsuario: 1,
    );

    Usuario usuario = Usuario(name: 'name', email: 'email', password: 'password');
    
    

    await controller.addUsuario(usuario);
    await controller.addVideo(video1);
    await controller.addVideo(video2);
  }

  void pegarVideos() async{
    this.videos = await controller.getAllVideos();
     print(this.videos![0].durationMinutes);
   
   
  }

  @override
  void initState() {
    super.initState();
    adicionarVideos();
    pegarVideos();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CatoVideo"),
        actions: [
          TextButton(
            onPressed: () {
              // Ação do botão "Logar"
              Navigator.pop(context); // Volta para a tela anterior
            },
            child: Text(
              "Logar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              // Ação do botão "Cadastrar"
              Navigator.pushNamed(context, "/cadastro"); // Vai para tela de cadastro
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
        child: VideoList(listaDeVideos),
      ),
    );
  } 
}

