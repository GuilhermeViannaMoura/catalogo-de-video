import 'package:flutter/material.dart';
import '../classes/video.dart';


class VideoList extends StatelessWidget {
  final List<Video> videos;

  VideoList(this.videos);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
              items: <String>['Gênero', 'Ação', 'Comédia', 'Drama', 'Ficção'].map((String value) {
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
              items: <String>['Tipo', 'Trailer', 'Filme', 'Série', 'Documentário'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Lógica para tratar a seleção do menu Tipo
              },
              value: 'Tipo',
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Adiciona espaçamento interno ao Card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(videos[index].title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(), // Adiciona uma divisória antes das informações
                            Text('Descrição: ${videos[index].description}'),
                            Divider(), // Adiciona uma divisória após cada informação
                            Text('Tipo: ${videos[index].type}'),
                            Divider(),
                            Text('Classificação: ${videos[index].ageRestriction}'),
                            Divider(),
                            Text('Duração: ${videos[index].durationMinutes}'),
                            Divider(),
                            Text('Data de Lançamento: ${videos[index].releaseDate}'),
                            Divider(),
                            Text('Thumbnail: ${videos[index].thumbnailImageId}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 2, // Adiciona uma sombra ao Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Adiciona borda arredondada ao Card
                  side: BorderSide(color: Colors.grey), // Adiciona uma borda cinza ao Card
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}