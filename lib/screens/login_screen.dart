import 'package:flutter/material.dart';
import 'package:flutter_juntos_aprender/components/decoration_inputs_login.dart';
import 'package:flutter_juntos_aprender/services/auth_service.dart';
import 'package:flutter_juntos_aprender/utils/colors.dart';
import 'package:flutter_juntos_aprender/utils/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool queroEntrar = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 228, 239),
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                MyColors.topoGradiente,
                MyColors.baixoGrandiente,
              ]))),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset('assets/logo.png', height: 180),
                      const Text(
                        "Juntos Aprender",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 32),
                      TextFormField(
                        controller: _emailController,
                        decoration: getLoginInputDecoration("E-mail"),
                        validator: (String? value) {
                          if (value == null) {
                            return "O e-mail não pode ser vazio";
                          }
                          if (value.length < 5) {
                            return "O e-mail é muito curto";
                          }
                          if (!value.contains("@")) {
                            return "O e-mail não é válido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _senhaController,
                        decoration: getLoginInputDecoration("Senha"),
                        validator: (String? value) {
                          if (value == null) {
                            return "A senha não pode ser vazia";
                          }
                          if (value.length < 3) {
                            return "A senha é muito curta";
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 8),
                      Visibility(
                        visible: !queroEntrar,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  getLoginInputDecoration("Confirme a Senha"),
                              obscureText: true,
                              validator: (String? value) {
                                if (value == null) {
                                  return "A confirmação de senha não pode ser vazia";
                                }
                                if (value.length < 3) {
                                  return "A confirmação de senha é muito curta";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _nomeController,
                              decoration: getLoginInputDecoration("Nome"),
                              validator: (String? value) {
                                if (value == null) {
                                  return "O nome não pode ser vazio";
                                }
                                if (value.length < 3) {
                                  return "O nome é muito curto";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          buttonPrincipalPressed();
                        },
                        child: Text((queroEntrar) ? "Entrar" : "Cadastrar"),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.purple, // Cor do botão
                        ),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: (queroEntrar)
                                    ? "Ainda não possui uma conta? "
                                    : "Já tem uma conta? ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: (queroEntrar) ? "Cadastre-se!" : "Entre!",
                                style: TextStyle(color: Colors.purple),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buttonPrincipalPressed() {
    String name = _nomeController.text;
    String email = _emailController.text;
    String password = _senhaController.text;

    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        print("Entrada Válidada");
        _authService
            .login(context: context, email: email, password: password)
            .then((String? error) {
          if (error != null) {
            showSnackBar(context: context, texto: error);
          }
        });
      } else {
        print("Cadastro Validado");
        print(
            "${_emailController.text}, ${_senhaController.text}, ${_nomeController.text} ");
        _authService
            .register(name: name, password: password, email: email)
            .then(
          (String? error) {
            //Voltou com erro
            if (error != null) {
              showSnackBar(context: context, texto: error);
            } else {
              //Deu certo
              showSnackBar(
                  context: context,
                  texto: "Cadastro realizado com sucesso!",
                  isErro: false);
            }
          },
        );
      }
    } else {
      print("Form inválido");
    }
  }
}
