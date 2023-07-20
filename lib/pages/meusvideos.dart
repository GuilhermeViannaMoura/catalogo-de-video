import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'editarvideo.dart';
import '../classes/video.dart';
import "login.dart";
import '../classes/usuario.dart';
import 'dart:convert';

class MeusVideosPage extends StatefulWidget {
  final Usuario? usuarioLogado;
  const MeusVideosPage({Key? key, this.usuarioLogado}) : super(key: key);

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
        title: Text("Meus Vídeos"),
        actions: [
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
      body: AccordionPage(videos: listaDeVideos),
    );
  }
}

class AccordionPage extends StatelessWidget {
  final List<Video> videos;

  AccordionPage({Key? key, required this.videos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _headerStyle = const TextStyle(
        color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
    final _contentStyleHeader = const TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
    final _contentStyle = const TextStyle(
        color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

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
        children: videos.map((video) {
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
                Text("Tipo: ${video.type}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Classificação Indicativa: ${video.ageRestriction}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Duração: ${video.durationMinutes}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Data de Lançamento: ${video.releaseDate}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Gêneros: ${video.thumbnailImageId}", style: _contentStyle),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Ação do botão "Remover"
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
                            builder: (context) => TelaEditarVideo(video: video),
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
            // onOpenSection: () => print('onOpenSection ...'),
            // onCloseSection: () => print('onCloseSection ...'),
          );
        }).toList(),
      ),
    );
  }
}
