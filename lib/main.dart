import 'package:flutter/material.dart';
import 'package:news_universe/src/core/news_universe.dart';
import 'package:news_universe/src/initialize_hive.dart';
import 'package:news_universe/src/shared/utils/config.dart';

void main() async {
  await Config.load();
  await InitializeHive.init();
  runApp(NewsUniverse());
}
