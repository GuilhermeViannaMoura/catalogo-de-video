import 'package:flutter/material.dart';
import '../classes/video.dart';
import '../classes/genero.dart';
import '../controller/db_controller.dart';
import '../util/video_genero_helper.dart';

class VideoList extends StatefulWidget {
  

  VideoList();
  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final Map<int, String> tipos = {0:'Filme', 1:'Serie'};
  late DataBaseController controller;
  List<Video>? videos;
  Map<int,List<Genero>>? infos;

  String? _tipo = 'Tipo';
  String? _genero = 'Gênero';
  
  _VideoListState(){
    controller = DataBaseController();
  }

  
  void pegarVideos() async{
    controller.getAllVideos().then((data) => 
      filtrarVideo(data)
    );
  }

  void pegarGeneros() async{
    Future.wait([controller.getAllGeneros(), controller.getAllVideosGeneros()]).then((List values) => setState(() {
        infos = getMapGenerosByVideoId(values[0], values[1]);
      }));
  }

  void filtrarVideo(List<Video>? videos){
      List<Video> f = [];
      if(videos != null){
        if(_tipo == 'Tipo'){
          f = videos;
        }else{
        for(int i=0; i < videos.length; i++){
          if(tipos[videos[i].type]== _tipo){
            f.add(videos[i]);
          }
        }
        }
      }
      setState(() {
        this.videos = filtraGeneros(f);
      });
  }

  List<Video> filtraGeneros(List<Video> videos){
    List<Video> f = [];
      if(_genero == 'Gênero' ){
        f = videos;
      }else{
        for(int i=0; i < videos.length; i++){
          String generos = stringGeneros(videos[i].id);
          final splitted = generos.split(', ');
          for(int j=0; j < splitted.length; j++){
            if(splitted[j] == _genero){
              f.add(videos[i]);
            }
          }
        }
      }
    return f;
  }

  @override
  void initState() {
    super.initState();
    pegarVideos();
    pegarGeneros();
  }


  String stringGeneros(int? idVideo){
    String frase = '';
    List<Genero>? videoGeneros = infos?[idVideo!];
    if(videoGeneros != null){
    for(int i = 0; i < videoGeneros.length; i ++){
      if(frase == ''){
        frase = frase + videoGeneros[i].name;
      }else{
      frase = frase+', '+ videoGeneros[i].name;
      }
    }
    }
    return frase;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              items: <String>['Gênero', 'Aventura', 'Acao','Suspense','Terror','Drama', 'Comedia'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if(newValue != _genero){
                setState(() {
                  _genero = newValue;
                });
                pegarVideos();
                }
              },
              value: _genero,
            ),
            DropdownButton<String>(
              items: <String>['Tipo', 'Filme', 'Serie'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if(newValue != _tipo){
                  setState(() {
                  _tipo = newValue;
                });
                pegarVideos();
                }
              },
              value: _tipo,
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: videos?.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text('Titulo: ${videos?[index].title}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            Text('Descrição: ${videos?[index].description}'),
                            Divider(), 
                            Text('Tipo: ${tipos[videos?[index].type]}'),
                            Divider(),
                            Text('Classificação: ${videos?[index].ageRestriction}'),
                            Divider(),
                            Text('Duração: ${videos?[index].durationMinutes}'),
                            Divider(),
                            Text('Data de Lançamento: ${videos?[index].releaseDate}'),
                            Divider(),
                            Text('Generos: ${stringGeneros(videos?[index].id)}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 2, 
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.grey), 
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}