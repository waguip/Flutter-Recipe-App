import 'package:flutter/material.dart';

class searchField extends StatelessWidget {
  const searchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black, blurRadius: 40, spreadRadius: 1.0)
      ]),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Procurar Receitas',
          filled: true,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
