import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home.dart';

class HomeMain extends StatelessWidget {
  int pag = 0;
  late PageController pc;

  HomeMain({super.key});

  void initState() {
    pc = PageController(initialPage: pag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [Home()],
      ),
    );
  }
}
