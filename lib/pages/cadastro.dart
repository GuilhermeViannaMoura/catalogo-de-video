import 'package:flutter/material.dart';
import 'package:videos/controller/db_controller.dart';
import 'package:videos/pages/login.dart';
import '../classes/usuario.dart';



class CadastroPage extends StatefulWidget {
  static const routeName = "/cadastro";

  CadastroPage({Key? key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  String? _email, _password, _name;
  late DataBaseController controller;
  final _formKey = GlobalKey<FormState>();

  _CadastroPageState(){
    this.controller = DataBaseController();
  }
  
  void _submit() async {
    final form = _formKey.currentState;

    if (form!.validate()) {      
      form.save();

      try{
       bool userCheck = await controller.checkCadastro(_email!);
        if (userCheck) {
          await controller.addUsuario(Usuario(name: _name!, email: _email!, password: _password!));
          Navigator.pushNamed(context, LoginPage.routeName);
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
      appBar: AppBar(title: Text("CatalogoV")),
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
                        onSaved: (newValue) => _name = newValue,
                        decoration: InputDecoration(
                          labelText: 'Nome',
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
              child: Text("Cadastar"),
            ),
          ],
        ),
      ),
    );
  }
}