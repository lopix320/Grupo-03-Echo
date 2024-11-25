import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pi_flutter/components/custom_checkbox.dart';
import 'package:pi_flutter/components/experience_info.dart';
import 'package:pi_flutter/components/formation_info.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/cuidador_form_page.dart';
import 'package:pi_flutter/views/login_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:pi_flutter/views/register_page.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class BackgroundCheck extends StatefulWidget {
  dynamic firtForm;
  BackgroundCheck({super.key, required this.firtForm});
  @override
  _BackgroundCheckState createState() => _BackgroundCheckState();
}

class _BackgroundCheckState extends State<BackgroundCheck> {
  dynamic loading = false;
  void startDelayedFunction() {
    print('Iniciando...');

    // Define um delay de 5 segundos
    Future.delayed(Duration(seconds: 5), () {
      onDelayedComplete(); // Chama a função desejada após o delay
    });
  }

  void onDelayedComplete() {
    setState(() {
      loading = false;
    });
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CuidadorPageForm(
                firtForm: widget.firtForm,
              )));
    });
  }

  @override
  void initState() {
    loading = true;
    startDelayedFunction();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Login'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verificando antecedentes criminais",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: loading
                        ? CircularProgressIndicator()
                        : Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 40,
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
