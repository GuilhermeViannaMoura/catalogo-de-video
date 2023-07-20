import 'package:flutter/material.dart';
import 'package:videos/classes/video_genero.dart';
import 'package:videos/pages/cadastro.dart';
import 'package:videos/pages/videosAnonimo.dart';
import 'package:videos/pages/videosLogado.dart';
import '../controller/db_controller.dart';
import '../classes/usuario.dart';
import '../classes/genero.dart';
import '../classes/video.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _password;
  late DataBaseController controller;
  final _formKey = GlobalKey<FormState>();

  _LoginPageState(){
    this.controller = DataBaseController();
  }


  void _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {      
      form.save();

      try{
        Usuario user = await controller.getLogin(_email!, _password!);
        if (user.id != -1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VideosLogadoPage(usuarioLogado: user)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User not registered!')),
          );
        }
      } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );     
      }
    }
  }


  void _setUp() async {
    Genero genero1 = Genero(
      name: "Aventura",
    );
    Genero genero2 = Genero(
      name: "Acao",
    );
    Genero genero3 = Genero(
      name: "Suspense",
    );
    Genero genero4 = Genero(
      name: "Terror",
    );
    Genero genero5 = Genero(
      name: "Drama",
    );
    Genero genero6 = Genero(
      name: "Comedia",
    );
    int genero1Id = await controller.addGenero(genero1);
    int genero2Id = await controller.addGenero(genero2);
    int genero6Id = await controller.addGenero(genero6);
  
    Usuario user = Usuario(name: 'name', email: 'email', password: 'password');

    Video video1 = Video(
      title: "Vídeo 1",
      description: "Descrição do Vídeo 1",
      type: 0,
      ageRestriction: "Livre",
      durationMinutes: 150,
      releaseDate: "2023-01-01",
      idUsuario: 1,
    );

    

    Video video2 = Video(
      title: "Vídeo 2",
      description: "Descrição do Vídeo 2",
      type: 1,
      ageRestriction: "18+",
      durationMinutes: 105,
      releaseDate: "2023-03-15",
      idUsuario: 1,
    );

    await controller.addUsuario(user);
    int video1Id = await controller.addVideo(video1);
    int video2Id = await controller.addVideo(video2);
    VideoGenero videoGenero1 = VideoGenero(videoId: video1Id, genreId: genero1Id);
    VideoGenero videoGenero4 = VideoGenero(videoId: video1Id, genreId: genero2Id);
    VideoGenero videoGenero2 = VideoGenero(videoId: video2Id, genreId: genero6Id);
    VideoGenero videoGenero3 = VideoGenero(videoId: video2Id, genreId: genero1Id);
    await controller.addVideoGenero(videoGenero1);
    await controller.addVideoGenero(videoGenero2);
    await controller.addVideoGenero(videoGenero3);
    await controller.addVideoGenero(videoGenero4);

  }

  @override
  void initState(){
    super.initState();
    _setUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CatalogoV"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        onSaved: (newValue) => _email = newValue,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        onSaved: (newValue) => _password = newValue,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text("Entrar"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, VideosAnonimoPage.routeName);
                  },
                  child: Text("Acesso Anônimo"),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context,CadastroPage.routeName);
                  },
                  child: Text("Cadastrar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
