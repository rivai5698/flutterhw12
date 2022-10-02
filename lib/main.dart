import 'package:flutter/material.dart';
import 'package:flutterhw12/pages/category_page.dart';
import 'package:flutterhw12/provider/item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: const CategoryPage(),
    ),
  ));
}

