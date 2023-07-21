import 'package:videos/classes/usuario.dart';
import 'package:videos/controller/db_controller.dart';
import '../classes/video.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import '../pages/editarVideo.dart';

class AccordionPage extends StatefulWidget {
  final Usuario? usuario;
  

  AccordionPage({this.usuario});
  @override
  State<AccordionPage> createState() => _AccordionPageState();
}

class _AccordionPageState extends State<AccordionPage> {
  List<Video>? videos;
  late DataBaseController controller;

  final Map<int, String> tipo = {0: 'Filme', 1: 'Serie'};
  final _headerStyle = const TextStyle(
    color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  /* final _contentStyleHeader = const TextStyle(
    color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700); */
  final _contentStyle = const TextStyle(
    color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  _AccordionPageState(){
    this.controller = DataBaseController();
  }

  void removerVideo(Video video) async{
    await controller.deleteVideo(video);
    pegarVideos();
  }

  void pegarVideos() async{
    controller.getAllVideos().then((data) =>
      setState(() {
        this.videos = userVideos(data!);
      })
    );
  }

  @override
  void initState() {
    super.initState();
    pegarVideos();
  }

  List<Video> userVideos(List<Video> videos){
      List<Video> l = [];
      for(int i = 0; i < videos.length; i++){
        if(videos[i].idUsuario == widget.usuario!.id){
          l.add(videos[i]);
        }
      }
      return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: Accordion(
        maxOpenSections: 1,
        headerBackgroundColorOpened: Colors.black54,
        scaleWhenAnimating: true,
        openAndCloseAnimation: true,
        headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
        sectionClosingHapticFeedback: SectionHapticFeedback.light,
        children: videos?.map((video) {
          return AccordionSection(
            isOpen: true,
            leftIcon: const Icon(Icons.live_tv, color: Colors.white),
            headerBackgroundColor: Colors.blue,
            headerBackgroundColorOpened: Colors.black,
            header: Text(video.title, style: _headerStyle),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Descrição: ${video.description}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Tipo: ${tipo[video.type]}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Classificação Indicativa: ${video.ageRestriction}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Duração: ${video.durationMinutes}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Data de Lançamento: ${video.releaseDate}", style: _contentStyle),
                SizedBox(height: 3),
                //Text("Gêneros: ${video.thumbnailImageId}", style: _contentStyle),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        removerVideo(video);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text('Remover'),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarVideoPage(video: video, usuario: widget.usuario),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      child: Text('Editar'),
                    ),
                  ],
                ),
              ],
            ),
            contentHorizontalPadding: 20,
            contentBorderWidth: 1,
            contentVerticalPadding: 10,
          );
        }).toList() ?? [] ,
      ),
    );
  }
}
