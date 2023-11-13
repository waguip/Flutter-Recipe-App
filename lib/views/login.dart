import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, _) => [appBar()],
        body: ListView(
          children: [
            loginform(),
          ],
        ),
      ),
    );
  }

  SliverAppBar appBar() {
    return const SliverAppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person),
          SizedBox(width: 10),
          Text('Login', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      snap: true,
      floating: true,
    );
  }

  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  late String titulo;
  late String actionButton;
  late String toggleButton;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;

      if (isLogin) {
        titulo = "Bem vindo!";
        actionButton = "Login";
        toggleButton = "Cadastre-se agora.";
      } else {
        titulo = "Crie sua conta!";
        actionButton = "Cadastrar";
        toggleButton = "Fazer login.";
      }
    });
  }

  Future login() async {
    try {
      await AuthService().login(email.text, senha.text);
      print("${email.text}, ${senha.text}");
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
      print(e.message);
    }
  }

  Future register() async {
    try {
      await AuthService().register(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );
    }
  }

  loginform() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 100),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe o email corretamente!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: TextFormField(
                  controller: senha,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Informe a senha!';
                    } else if (value.length < 6) {
                      return 'A senha deve ter no mínimo 6 caracteres!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (isLogin) {
                        print('login');
                        login();
                      } else {
                        print('registro');
                        register();
                      }
                    } else {
                      print('form invalido');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          actionButton,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setFormAction(!isLogin),
                child: Text(toggleButton),
              )
            ],
          ),
        ),
      ),
    );
  }
}
