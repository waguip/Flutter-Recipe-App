import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/favorites_repository.dart';
import 'package:flutter_application_1/views/home_navigation.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesRepository(),
      child: MaterialApp(
        home: HomeNavigation(),
        theme: ThemeData.dark(),
      ),
    ),
  );
}
