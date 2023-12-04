import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/db.dart';
import 'package:sqflite/sqlite_api.dart';
import '../models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepository extends ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  CategoryRepository() {
    _setupCategories();
    _setupDataCategories();
    _readCategories();
  }

  _setupCategories() async {
    const String table = '''
      CREATE TABLE IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        iconImage TEXT,
        categoryImage TEXT,
        tag TEXT 
      );
    ''';
    Database db = await DB.instance.database;
    await db.execute(table);
  }

  _setupDataCategories() async {
    if (await _categoriesTableIsEmpty()) {
      Uri uri = Uri.https('yummly2.p.rapidapi.com', 'categories/list');

      final response = await http.get(uri, headers: {
        "x-rapidapi-key": "828f2dd24dmshb55d4148d3f6819p19518ejsn2b485e6035ac",
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
      });

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> categories = json['browse-categories'];
        Database db = await DB.instance.database;
        Batch batch = db.batch();

        categories.forEach((category) {
          batch.insert('categories', {
            'name': category['display']['displayName'],
            'iconImage': category['display']['iconImage'],
            'categoryImage': category['display']['categoryImage'],
            'tag': category['display']['tag'],
          });
        });

        await batch.commit(noResult: true);
      }
    }
  }

  _categoriesTableIsEmpty() async {
    Database db = await DB.instance.database;
    List results = await db.query('categories');
    return results.isEmpty;
  }

  _readCategories() async {
    Database db = await DB.instance.database;
    List results = await db.query('categories');

    _categories = results.map((e) {
      return CategoryModel(
        name: e['name'],
        iconImage: e['iconImage'],
        categoryImage: e['categoryImage'],
        tag: e['tag'].toString(),
      );
    }).toList();

    notifyListeners();
  }
}
