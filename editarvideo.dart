import 'package:flutter/material.dart';

import 'meusvideos.dart';

class TelaEditarVideo extends StatefulWidget {
  final Video video;

  TelaEditarVideo({required this.video});

  @override
  _TelaEditarVideoState createState() => _TelaEditarVideoState();
}

class _TelaEditarVideoState extends State<TelaEditarVideo> {
  final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _descricao;
  String? _tipo;
  String? _classificacao;
  String? _duracao;
  String? _dataLancamento;
  String? _genero;

  @override
  void initState() {
    super.initState();
    // Preenche os campos do formulário com as informações do vídeo
    _nome = widget.video.nome;
    _descricao = widget.video.descricao;
    _tipo = widget.video.tipo;
    _classificacao = widget.video.classificacao;
    _duracao = widget.video.duracao;
    _dataLancamento = widget.video.dataLancamento;
    _genero = widget.video.genero;
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
                initialValue: _duracao,
                decoration: InputDecoration(labelText: 'Duração'),
                onChanged: (value) => _duracao = value,
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
              TextFormField(
                initialValue: _genero,
                decoration: InputDecoration(labelText: 'Gênero'),
                onChanged: (value) => _genero = value,
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
                    widget.video.nome = _nome!;
                    widget.video.descricao = _descricao!;
                    widget.video.tipo = _tipo!;
                    widget.video.classificacao = _classificacao!;
                    widget.video.duracao = _duracao!;
                    widget.video.dataLancamento = _dataLancamento!;
                    widget.video.genero = _genero!;

                    // Retorne à tela anterior
                    Navigator.pop(context);
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
