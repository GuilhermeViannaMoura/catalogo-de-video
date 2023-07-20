import 'package:flutter/material.dart';
import 'package:videos/usuario.dart';
import 'video.dart';
import 'database_helper.dart';


class Tela4 extends StatefulWidget {
  const Tela4({Key? key});

  @override
  State<Tela4> createState() => _Tela4State();
}


class _Tela4State extends State<Tela4> {
  List<Video> listaDeVideos = []; // Crie a lista de vídeos
  List<Usuario> listadeusuarios = [];

  @override
  void initState() {
    super.initState();
    
    // Adicione alguns vídeos ao banco de dados antes de exibir a lista
    //adicionarVideos();
    // Carregue a lista de vídeos quando a tela for exibida
    //carregarVideos();
    adicionarUsuario();
    carregarUsuarios();
  }
  void adicionarUsuario()async{
    await DatabaseHelper.getDB();
    Usuario usuario0 = Usuario(name: 'name', email: 'email', password: 'password');
    Usuario usuario1 = Usuario(name: 'name1', email: 'email1', password: 'password1');
    await DatabaseHelper.addUsuario(usuario0);
    await DatabaseHelper.addUsuario(usuario1);
  }

  void adicionarVideos() async {
    // Crie alguns objetos Video com os dados dos vídeos que deseja adicionar
    await DatabaseHelper.getDB();
    Video video1 = Video(
      title: "Vídeo 1",
      description: "Descrição do Vídeo 1",
      type: 0,
      ageRestriction: "Livre",
      durationMinutes: 150,
      thumbnailImageId: "id_da_imagem_1",
      releaseDate: "2023-01-01",
      //idUsuario: 1,
      genre: 'Comédia' // Defina o ID do usuário associado ao vídeo (você pode alterar para o ID correto)
    );

    Video video2 = Video(
      title: "Vídeo 2",
      description: "Descrição do Vídeo 2",
      type: 1,
      ageRestriction: "18+",
      durationMinutes: 105,
      thumbnailImageId: "id_da_imagem_2",
      releaseDate: "2023-03-15",
      //idUsuario: 1,
      genre: 'Ação' // Defina o ID do usuário associado ao vídeo (você pode alterar para o ID correto)
    );

    // Adicione os vídeos ao banco de dados usando o método addVideo da classe DatabaseHelper
    await DatabaseHelper.addVideo(video1);
    await DatabaseHelper.addVideo(video2);
  }

  void carregarVideos() async {
    // Carregue a lista de vídeos do banco de dados usando o método getAllVideos() da classe DatabaseHelper
    List<Video>? videos = await DatabaseHelper.getAllVideos();

    if (videos != null) {
      setState(() {
        listaDeVideos = videos;
      });
    }
  }
  void carregarUsuarios() async {
    // Carregue a lista de vídeos do banco de dados usando o método getAllVideos() da classe DatabaseHelper
    List<Usuario>? usuarios = await DatabaseHelper.getAllUsuarios();

    if (usuarios != null) {
      setState(() {
        listadeusuarios = usuarios;
      });
    }
  }

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
                            Text('Gênero: ${videos[index].genre}'),
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