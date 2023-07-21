import 'package:flutter/material.dart';
import 'package:videos/controller/db_controller.dart';
import '../classes/video.dart';
import '../classes/usuario.dart';
import 'meusVideos.dart';

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
  final Map<String, int> tiposReverse = {'Filme':0, 'Serie':1};

  String? _nome;
  String? _descricao;
  String? _tipo;
  String? _classificacao;
  int? _duracao;
  String? _dataLancamento;

  _EditarVideoPageState(){
    this.controller = DataBaseController();
  }

  void update()async{
    await controller.updateVideo(widget.video!);
    Navigator.push(context, MaterialPageRoute(builder: (context) => MeusVideosPage(usuarioLogado: widget.usuario)));
  }

  @override
  void initState() {
    super.initState();
    _nome = widget.video!.title;
    _descricao = widget.video!.description;
    _tipo = tipos[widget.video!.type];
    _classificacao = widget.video!.ageRestriction;
    _duracao = widget.video!.durationMinutes;
    _dataLancamento = widget.video!.releaseDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Vídeo"),
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
                onChanged: (value) => _nome = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _descricao,
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => _descricao = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _tipo,
                decoration: InputDecoration(labelText: 'Tipo'),
                onChanged: (value) => _tipo = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _classificacao,
                decoration: InputDecoration(labelText: 'Classificação'),
                onChanged: (value) => _classificacao = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _duracao.toString(),
                decoration: InputDecoration(labelText: 'Duração'),
                onChanged: (value) => _duracao = int.parse(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _dataLancamento,
                decoration: InputDecoration(labelText: 'Data de Lançamento'),
                onChanged: (value) => _dataLancamento = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Salve as alterações e retorne à tela anterior somente se o formulário for válido
                  if (_formKey.currentState!.validate()) {
                    // Salve as alterações aqui
                    // Exemplo: chame uma função para salvar as alterações no banco de dados
                    // Atualize o objeto "video" com os novos valores
                    widget.video!.title = _nome!;
                    widget.video!.description = _descricao!;
                    widget.video!.type = tiposReverse[_tipo?.toLowerCase()]!;
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
                  // Simplesmente retorne à tela anterior sem salvar as alterações
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
