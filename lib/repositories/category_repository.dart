import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryRepository {
  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(CategoryModel(
      name: 'Café da manhã',
      iconPath: 'assets',
      icon: const Icon(Icons.fastfood),
      boxColor: const Color.fromARGB(255, 133, 116, 92),
    ));

    categories.add(CategoryModel(
      name: 'Almoço',
      iconPath: 'assets',
      icon: const Icon(Icons.fastfood),
      boxColor: const Color.fromARGB(255, 47, 79, 154),
    ));

    categories.add(CategoryModel(
      name: 'Lanche',
      iconPath: 'assets',
      icon: const Icon(Icons.fastfood),
      boxColor: const Color.fromARGB(255, 108, 116, 18),
    ));

    categories.add(CategoryModel(
      name: 'Doce',
      iconPath: 'assets',
      icon: const Icon(Icons.fastfood),
      boxColor: const Color.fromARGB(255, 100, 42, 147),
    ));

    return categories;
  }
}
