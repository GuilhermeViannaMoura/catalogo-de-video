import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'editarvideo.dart';
import "home.dart";

import 'dart:convert';

class Tela2 extends StatefulWidget {
  const Tela2({Key? key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class Video {
  String nome;
  String descricao;
  String tipo;
  String classificacao;
  String duracao;
  String dataLancamento;
  String genero;

  Video({
    required this.nome,
    required this.descricao,
    required this.tipo,
    required this.classificacao,
    required this.duracao,
    required this.dataLancamento,
    required this.genero,
  });
}

class _Tela2State extends State<Tela2> {

  final List<Video> listaDeVideos = [
    Video(
      nome: "Vídeo 1",
      descricao: "Descrição do Vídeo 1",
      tipo: "Filme",
      classificacao: "Livre",
      duracao: "2:30",
      dataLancamento: "01/01/2023",
      genero: "Ação",
    ),
    Video(
      nome: "Vídeo 2",
      descricao: "Descrição do Vídeo 2",
      tipo: "Série",
      classificacao: "18+",
      duracao: "1:45",
      dataLancamento: "15/03/2023",
      genero: "Terror",
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
            header: Text(video.nome, style: _headerStyle),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Descrição: ${video.descricao}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Tipo: ${video.tipo}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Classificação Indicativa: ${video.classificacao}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Duração: ${video.duracao}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Data de Lançamento: ${video.dataLancamento}", style: _contentStyle),
                SizedBox(height: 3),
                Text("Gêneros: ${video.genero}", style: _contentStyle),
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
