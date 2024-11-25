import 'package:flutter/material.dart';
import 'package:pi_flutter/provider/api_user.dart';
import 'package:pi_flutter/repository/user_repository.dart';
import 'package:pi_flutter/views/background_check.dart';
import 'package:pi_flutter/views/cuidador_form_page.dart';
import 'package:pi_flutter/views/login_page.dart';
import 'package:pi_flutter/views/main_page.dart';
import 'package:pi_flutter/views/paciente_form_page.dart';
import 'package:pi_flutter/views/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RegisterCuidadorForm extends StatefulWidget {
  @override
  _RegisterCuidadorFormState createState() => _RegisterCuidadorFormState();
}

class _RegisterCuidadorFormState extends State<RegisterCuidadorForm> {
  String nome = '';
  String email = '';
  String telefone = '';
  String password = '';
  String cpf = '';
  String rua = '';
  String cep = '';
  bool aceitarTermos = false; // Novo estado para o checkbox
  bool showError = false;

  bool seePassword = false;
  bool loginStatus = false;

  // Variáveis para Estados e Cidades
  String? selectedEstado;
  String? selectedCidade;

  // Listas de exemplo
  final List<String> estados = ['SP', 'RJ', 'MG', 'ES'];
  final Map<String, List<String>> cidadesPorEstado = {
    'SP': ['São Paulo', 'Campinas', 'Santos'],
    'RJ': ['Rio de Janeiro', 'Niterói', 'Cabo Frio'],
    'MG': ['Belo Horizonte', 'Uberlândia', 'Ouro Preto'],
    'ES': ['Vitória', 'Vila Velha', 'Guarapari'],
  };

  // Método para obter cidades com base no estado selecionado
  List<String> getCidades() {
    if (selectedEstado != null) {
      return cidadesPorEstado[selectedEstado!] ?? [];
    }
    return [];
  }

  void _abrirTermosDeUso() async {
    const String url =
        "https://drive.google.com/file/d/1N8Nat6KVXgEWKacIcjKJk06_dHX1fmVQ/view?usp=sharing"; // Substitua pelo link dos seus termos
    // if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text("Não foi possível abrir os Termos de Uso")),
    //   );
    // }
  }

  void onSubmit(data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Material(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
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
                        _buildTextField(
                            'Nome Completo', 'Digite seu nome completo',
                            (text) {
                          setState(() => nome = text);
                        }),
                        _buildTextField(
                            'Email', 'Digite seu endereço de e-mail', (text) {
                          setState(() => email = text);
                        }),
                        _buildTextField('Telefone', 'Digite seu telefone',
                            (text) {
                          setState(() => telefone = text);
                        }),

                        _buildPasswordField('Senha', 'Digite sua Senha',
                            (text) {
                          setState(() => password = text);
                        }),
                        _buildTextField('CPF', 'Digite seu CPF', (text) {
                          setState(() => cpf = text);
                        }),
                        _buildTextField('Rua', 'Digite sua Rua', (text) {
                          setState(() => rua = text);
                        }),
                        _buildTextField('CEP', 'Digite seu CEP', (text) {
                          setState(() => cep = text);
                        }),

                        // Select Estado
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Estado',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedEstado,
                          items: estados.map((String estado) {
                            return DropdownMenuItem<String>(
                              value: estado,
                              child: Text(estado),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedEstado = newValue;
                              selectedCidade =
                                  null; // Resetar cidade ao mudar estado
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 25),
                            filled: true,
                            fillColor: Color.fromARGB(255, 232, 232, 232),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Select Cidade
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cidade',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: selectedCidade,
                          items: getCidades().map((String cidade) {
                            return DropdownMenuItem<String>(
                              value: cidade,
                              child: Text(cidade),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCidade = newValue;
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 25),
                            filled: true,
                            fillColor: Color.fromARGB(255, 232, 232, 232),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: aceitarTermos,
                              onChanged: (bool? value) {
                                setState(() {
                                  aceitarTermos = value ?? false;
                                  showError = false;
                                });
                              },
                            ),
                            const Text("Eu aceito os "),
                            GestureDetector(
                              onTap: _abrirTermosDeUso,
                              child: const Text(
                                "Termos de Uso",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize:
                                Size(MediaQuery.of(context).size.width, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 54, 105, 201),
                          ),
                          onPressed: email.isEmpty ||
                                  password.isEmpty ||
                                  telefone.isEmpty ||
                                  cep.isEmpty ||
                                  cpf.isEmpty ||
                                  rua.isEmpty ||
                                  !aceitarTermos ||
                                  selectedCidade != null &&
                                      selectedCidade!.isEmpty ||
                                  selectedEstado != null &&
                                      selectedEstado!.isEmpty ||
                                  nome.isEmpty
                              ? null
                              : () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (context) => BackgroundCheck(
                                                firtForm: {
                                                  "email": email,
                                                  "nome": nome,
                                                  "telefone": telefone,
                                                  "senha": password,
                                                  "cpf": cpf,
                                                  "rua": rua,
                                                  "cep": cep,
                                                  "estado": selectedEstado,
                                                  "cidade": selectedCidade,
                                                  "aceitarTermos":
                                                      aceitarTermos,
                                                },
                                              )));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => CuidadorPageForm(
                                  //           firtForm: {
                                  //             "email": email,
                                  //             "nome": nome,
                                  //             "telefone": telefone,
                                  //             "senha": password,
                                  //             "cpf": cpf,
                                  //             "rua": rua,
                                  //             "cep": cep,
                                  //             "estado": selectedEstado,
                                  //             "cidade": selectedCidade
                                  //           },
                                  //         )));
                                },
                          child: const Text('Continuar'),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text(
                              'Já tem uma conta?  Entrar',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            labelText: hint,
            filled: true,
            fillColor: const Color.fromARGB(255, 232, 232, 232),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(
      String label, String hint, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child:
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ),
        TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            labelText: hint,
            filled: true,
            fillColor: const Color.fromARGB(255, 232, 232, 232),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
        ),
      ],
    );
  }
}
