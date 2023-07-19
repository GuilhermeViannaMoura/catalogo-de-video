import 'package:flutter/material.dart';

class Tela4 extends StatefulWidget {
  const Tela4({Key? key});

  @override
  State<Tela4> createState() => _Tela4State();
}

class Video {
  final String nome;
  final String descricao;
  final String tipo;
  final String classificacao;
  final String duracao;
  final String dataLancamento;
  final String genero;

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

class _Tela4State extends State<Tela4> {
  
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
        title: Text("Anônimo"),
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
              Navigator.pushNamed(context, "/tela3"); // Vai para tela de cadastro
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
                        title: Text(videos[index].nome),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(), // Adiciona uma divisória antes das informações
                            Text('Descrição: ${videos[index].descricao}'),
                            Divider(), // Adiciona uma divisória após cada informação
                            Text('Tipo: ${videos[index].tipo}'),
                            Divider(),
                            Text('Classificação: ${videos[index].classificacao}'),
                            Divider(),
                            Text('Duração: ${videos[index].duracao}'),
                            Divider(),
                            Text('Data de Lançamento: ${videos[index].dataLancamento}'),
                            Divider(),
                            Text('Gênero: ${videos[index].genero}'),
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