import 'package:flutter/material.dart';
import 'package:videos/controller/db_controller.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import 'meusVideos.dart';
import '../classes/genero.dart';
import '../util/video_genero_helper.dart';

class EditarVideoPage extends StatefulWidget {
  final Video? video;
  final Usuario? usuario;
  static const routeName = "/editarVideo";

  EditarVideoPage({Key? key, this.video, this.usuario}): super(key:key);

  @override
  _EditarVideoPageState createState() => _EditarVideoPageState();
}

class _EditarVideoPageState extends State<EditarVideoPage> {
  final _formKey = GlobalKey<FormState>();
  late DataBaseController controller;
  final Map<int, String> tipos = {0:'Filme', 1:'Serie'};
  final Map<String, int> tiposReverse = {'filme':0, 'serie':1};
  final Map<String, int> generosReverse = {'aventura':1, 'acao':2, 'suspense':3,
   'terror':4, 'drama':5, 'comedia':6};

  String? _nome;
  String? _descricao;
  String? _tipo;
  String? _classificacao;
  int? _duracao;
  String? _dataLancamento;
  List<int> _generos = [];

  _EditarVideoPageState(){
    this.controller = DataBaseController();
  }

  void update()async{
    await controller.updateVideo(widget.video!, _generos);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MeusVideosPage(usuarioLogado: widget.usuario)));
  }

  void pegarGeneros() async{
    Future.wait([controller.getAllGeneros(), controller.getAllVideosGeneros()]).then((List values) => setState(() {
        _generos = setGeneros(getMapGenerosByVideoId(values[0], values[1])?[widget.video!.id]);
     }));
  }

  @override
  void initState() {
    super.initState();
    pegarGeneros();
    _nome = widget.video!.title;
    _descricao = widget.video!.description;
    _tipo = tipos[widget.video!.type];
    _classificacao = widget.video!.ageRestriction;
    _duracao = widget.video!.durationMinutes;
    _dataLancamento = widget.video!.releaseDate;
  }   

  void _onGenreSelected(bool? value, String genre) {
    print(value);
    setState(() {
      if (value == true) {
        _generos.add(generosReverse[genre.toLowerCase()]!);
      } else {
        _generos.remove(generosReverse[genre.toLowerCase()]!);
      }
    });
  }

  List<int> setGeneros(List<Genero>? infos){
    List<int> l = [];
    if(infos != null){
    for(int i = 0; i < infos.length; i ++){
      l.add(infos[i].id!);
    }
    }
    return l;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Vídeo"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => {if(value!= _nome){
                  _nome = value
                }},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um titulo';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => {if(value!= _descricao){
                  _descricao = value
                }},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField(
                value: _tipo,
                onChanged: (String? newValue)=> {if(newValue!= _tipo){
                  _tipo = newValue
                }},
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  ),
                items: <String>['Filme', 'Serie'].map((String value){
                  return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                }).toList(),
              ),
              TextFormField(
                initialValue: _classificacao,
                decoration: InputDecoration(labelText: 'Classificação'),
                onChanged: (value) => {if(value!= _classificacao){
                  _classificacao = value
                }},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma classificacao';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _duracao.toString(),
                decoration: InputDecoration(labelText: 'Duração'),
                onChanged: (value) => {if(int.parse(value)!= _duracao){
                  _duracao = int.parse(value)
                }},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma duracao';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _dataLancamento,
                decoration: InputDecoration(labelText: 'Data de Lançamento'),
                onChanged: (value) => {if(value!= _dataLancamento){
                  _dataLancamento = value
                }},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma data de lancamento';
                  }
                  return null;
                },
              ),
              Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: Text('Gêneros:')
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Aventura'),
                            value: _generos.contains(1),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Aventura');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Acao'),
                            value: _generos.contains(2),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Acao');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Suspense'),
                            value: _generos.contains(3),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Suspense');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Terror'),
                            value: _generos.contains(4),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Terror');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Drama'),
                            value: _generos.contains(5),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Drama');
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: 500,
                          child: CheckboxListTile(
                            title: Text('Comedia'),
                            value: _generos.contains(6),
                            onChanged: (bool? value) {
                              _onGenreSelected(value, 'Comedia');
                            },
                          ),
                        ),
                      ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.video!.title = _nome!;
                    widget.video!.description = _descricao!;
                    widget.video!.type = tiposReverse[_tipo!.toLowerCase()]!;
                    widget.video!.ageRestriction = _classificacao!;
                    widget.video!.durationMinutes = _duracao!;
                    widget.video!.releaseDate = _dataLancamento!;
                    update();
                  }
                },
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
      ),
    );
  }
}
