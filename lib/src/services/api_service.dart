import 'dart:convert';

import 'package:news_universe/src/models/object_reponse.dart';
import 'package:news_universe/src/shared/utils/config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final baseUrl = Config.apiUrl;

  Future<ObjectResponse> fetchAllArticles(
      {required String query, required int pageSize, String? filter}) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://newsapi.org/v2/everything?$query&pageSize=$pageSize&$filter'),
          headers: {'X-Api-Key': Config.apiKeyNews!});
      print(response.request!.url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ObjectResponse.fromMap(jsonData);
      } else {
        throw Exception('Failed to fetch items');
      }
    } catch (e) {
      throw Exception('Failed to fetch items');
    }
  }
}
