import 'package:flutter/material.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/cuidador_form_page.dart';
import 'package:pi_flutter/views/login_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:pi_flutter/views/paciente_form_page.dart';
import 'package:pi_flutter/views/register_page.dart';
import 'package:http/http.dart' as http;

class RegisterPacienteForm extends StatefulWidget {
  @override
  _RegisterPacienteFormState createState() => _RegisterPacienteFormState();
}

class _RegisterPacienteFormState extends State<RegisterPacienteForm> {
  String nome = '';
  String email = '';
  String telefone = '';
  String password = '';
  bool seePassword = false;
  bool loginStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                        child: Text(
                          'Preencha os campos abaixo para criar sua conta:',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 131, 133, 137)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text('Nome Completo',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                nome = text;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 25),
                              labelText: 'Digite seu nome completo',
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              filled: true,
                              fillColor: Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text('Email',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                email = text;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 25),
                              labelText: 'Digite seu endereço de e-mail',
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              filled: true,
                              fillColor: Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text('Telefone',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                telefone = text;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 25),
                              labelText: 'Digite seu telefone',
                              labelStyle: TextStyle(fontSize: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              filled: true,
                              fillColor: Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: Text(
                              'Senha',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          TextField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            obscureText: seePassword ? false : true,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: seePassword
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    seePassword = !seePassword;
                                  });
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 25),
                              labelText: 'Insira a senha da conta',
                              labelStyle: TextStyle(fontSize: 15),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              filled: true,
                              fillColor: Color.fromARGB(255, 232, 232, 232),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  Color.fromARGB(255, 54, 105, 201)),
                          onPressed: email.isEmpty &&
                                  password.isEmpty &&
                                  telefone.isEmpty &&
                                  nome.isEmpty
                              ? null
                              : () async {
                                  // loginStatus = await UserRepository(
                                  //         apiUser: ApiUser(
                                  //             httpClient: http.Client()))
                                  //     .login(email, password);
                                  // if (loginStatus) {
                                  //   print('Correto');
                                  //   // Navigator.of(context).pushNamed('/home');
                                  Navigator.of(context).pushReplacement(
                                      //-- Para eliminar o botao voltar da HomePage
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PacienteFormPage()));
                                  // } else {
                                  //   print('Login Invalido');
                                  // }
                                },
                          child: const Text('Continuar'),
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              //-- Para eliminar o botao voltar da HomePage
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text(
                          'Já tem uma conta?  Entrar',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
