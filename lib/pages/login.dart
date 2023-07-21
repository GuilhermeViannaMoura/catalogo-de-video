import 'package:flutter/material.dart';
import 'package:videos/pages/cadastro.dart';
import 'package:videos/pages/videosAnonimo.dart';
import 'package:videos/pages/videosLogado.dart';
import '../controller/db_controller.dart';
import '../classes/usuario.dart';
import '../util/video_genero_helper.dart';


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


  

  @override
  void initState(){
    super.initState();
    setUp(controller);
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
