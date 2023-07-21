import 'package:flutter/material.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import '../controller/db_controller.dart';
import '../pages/meusVideos.dart';

class AdicionarVideoPage extends StatefulWidget {
  final Usuario? usuario;
  static const routeName = "/adicionarVideo";

  AdicionarVideoPage({Key? key, this.usuario}): super(key:key);

  @override
  _AdicionarVideoPageState createState() => _AdicionarVideoPageState();
}

class _AdicionarVideoPageState extends State<AdicionarVideoPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<int,String> tipos = {0 : 'Filme', 1 : 'Serie'};
  late DataBaseController controller;

  String? _titulo;
  String? _descricao;
  int? _tipo;
  String? _classificacao;
  int? _duracao;
  String? _dataLancamento;

  _AdicionarVideoPageState(){
    this.controller = DataBaseController();
  }

  void _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {      
      form.save();

      try{
       bool videoCheck = await controller.checkCadastro(_titulo!);
        if (videoCheck) {
          await controller.addVideo(Video(title: _titulo!, 
          description: _descricao!, 
          type: _tipo!, 
          ageRestriction: _classificacao!, 
          durationMinutes: _duracao!, 
          releaseDate: _dataLancamento!, 
          idUsuario: widget.usuario!.id!),[1,2]);
          Navigator.push(context, MaterialPageRoute(builder: (context) => MeusVideosPage(usuarioLogado: widget.usuario)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email already in use!')),
          );
        }
      } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );     
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Adicionar Vídeo"),
          ),
          body: Center(
            child:Column(
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
                            onSaved: (newValue) => _titulo = newValue,
                            decoration: InputDecoration(
                              labelText: 'Titulo',
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
                            onSaved: (newValue) => _descricao = newValue,
                            decoration: InputDecoration(
                              labelText: 'Descrição',
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
                            onSaved: (newValue) => _tipo = int.parse(newValue!),
                            decoration: InputDecoration(
                              labelText: 'Tipo',
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
                            onSaved: (newValue) => _classificacao = newValue,
                            decoration: InputDecoration(
                              labelText: 'Classificação',
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
                            onSaved: (newValue) => _duracao = int.parse(newValue!),
                            decoration: InputDecoration(
                              labelText: 'Duração',
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
                            onSaved: (newValue) => _dataLancamento = newValue,
                            decoration: InputDecoration(
                              labelText: 'Data de Lançamento',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ), 
              ElevatedButton(
                onPressed: _submit,
                child: Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              ),
            ],
          ),
        ),
      );
}
}