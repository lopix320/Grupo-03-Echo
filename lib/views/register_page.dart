import 'package:flutter/material.dart';
import 'package:pi_flutter/components/register_cuidador_form.dart';
import 'package:pi_flutter/components/register_paciente_form.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  bool seePassword = false;
  bool loginStatus = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: const TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Tab(
                    child: Text(
                  "Cuidador",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                Tab(
                    child: Text(
                  "Paciente",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                )),
              ],
            ),
            title: const Text(
              'Registrar Conta',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ),
          body: TabBarView(
            children: [RegisterCuidadorForm(), RegisterPacienteForm()],
          ),
        ),
      ),
    );
  }
}
