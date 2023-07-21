import 'package:flutter/material.dart';
import '../classes/video.dart';
import '../classes/genero.dart';


class VideoList extends StatelessWidget {
  final List<Video>? videos;
  final Map<int, List<Genero>>? generos;
  final Map<int, String> tipos = {0:'Filme', 1:'Serie'};
  

  VideoList(this.videos, this.generos);


  String stringGeneros(int? idVideo){
    var frase = '';
    List<Genero>? videoGeneros = this.generos?[idVideo!];
    if(videoGeneros != null){
    for(int i = 0; i < videoGeneros.length; i ++){
      frase = frase+' '+ videoGeneros[i].name;
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
                // Lógica para tratar a seleção do menu Gênero
              },
              value: 'Gênero',
            ),
            DropdownButton<String>(
              items: <String>['Tipo', 'Filme', 'Série'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
              },
              value: 'Tipo',
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