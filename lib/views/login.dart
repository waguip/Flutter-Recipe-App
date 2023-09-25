import 'package:flutter/material.dart';

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
          children: const [],
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
}
