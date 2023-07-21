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
  final Map<String, int> tiposReverse = {'filme':0, 'serie':1};
  final Map<String, int> generosReverse = {'aventura':1, 'acao':2, 'suspense':3,
   'terror':4, 'drama':5, 'comedia':6};
  late DataBaseController controller;

  String? _titulo;
  String? _descricao;
  String? _tipo;
  String? _classificacao;
  int? _duracao;
  String? _dataLancamento;
  List<int> _generos = [];

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
          type: tiposReverse[_tipo?.toLowerCase()]!, 
          ageRestriction: _classificacao!, 
          durationMinutes: _duracao!, 
          releaseDate: _dataLancamento!, 
          idUsuario: widget.usuario!.id!),_generos);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Adicionar Vídeo"),
            automaticallyImplyLeading: false
          ),
          body: SingleChildScrollView(child: Center(
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
                          child: DropdownButtonFormField(
                            // onSaved: (newValue) => _tipo = newValue!,
                            value: _tipo,
                            onChanged: (String? newValue){
                              setState(() {
                                _tipo = newValue;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Tipo',
                              border: OutlineInputBorder(),
                            ),
                            items: <String>['Filme', 'Serie'].map((String value){
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
        ),)
      );
}
}