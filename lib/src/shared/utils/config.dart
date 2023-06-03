import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_universe/generated/assets.gen.dart';

class Config {
  static String? apiKeyNews = dotenv.env['NEWS_API_KEY'];
  static String? apiUrl = dotenv.env['API_URL'];

  static Future<void> load() async {
    await dotenv.load(fileName: Assets.env);
  }
}
