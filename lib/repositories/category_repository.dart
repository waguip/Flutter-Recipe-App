import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryRepository extends ChangeNotifier {
  final List<CategoryModel> _categories = [];

  UnmodifiableListView<CategoryModel> get categories =>
      UnmodifiableListView(_categories);

  save(CategoryModel categorie) {
    if (!_categories.contains(categorie)) _categories.add(categorie);
    notifyListeners();
  }

  saveAll(List<CategoryModel> categories) {
    for (var categorie in categories) {
      if (!_categories.contains(categorie)) _categories.add(categorie);
    }
    notifyListeners();
  }

  remove(CategoryModel categorie) {
    _categories.remove(categorie);
    notifyListeners();
  }

  // CategoryRepository.save(CategoryModel(
  //     name: 'Café da manhã',
  //     iconPath: 'assets',
  //     icon: const Icon(Icons.fastfood),
  //     boxColor: const Color.fromARGB(255, 133, 116, 92),
  //   ));

  //   _categories.add(CategoryModel(
  //     name: 'Almoço',
  //     iconPath: 'assets',
  //     icon: const Icon(Icons.fastfood),
  //     boxColor: const Color.fromARGB(255, 47, 79, 154),
  //   ));

  //   _categories.add(CategoryModel(
  //     name: 'Lanche',
  //     iconPath: 'assets',
  //     icon: const Icon(Icons.fastfood),
  //     boxColor: const Color.fromARGB(255, 108, 116, 18),
  //   ));

  //   _categories.add(CategoryModel(
  //     name: 'Doce',
  //     iconPath: 'assets',
  //     icon: const Icon(Icons.fastfood),
  //     boxColor: const Color.fromARGB(255, 100, 42, 147),
  //   ));
}
