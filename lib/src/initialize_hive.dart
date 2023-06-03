import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:news_universe/src/models/article_model.dart';

class InitializeHive {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    var appDocumentDir = await getApplicationDocumentsDirectory();
    var path = appDocumentDir.path;
    Hive
      ..init(path)
      ..registerAdapter(ArticleModelAdapter());
    await Hive.openBox('articlesBox');
  }
}
