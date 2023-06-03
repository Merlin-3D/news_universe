import 'dart:convert';

import 'package:news_universe/src/models/article_model.dart';

class ObjectResponse {
  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  ObjectResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'status': status});
    result.addAll({'totalResults': totalResults});
    result.addAll({'articles': articles.map((x) => x.toMap()).toList()});

    return result;
  }

  factory ObjectResponse.fromMap(Map<String, dynamic> map) {
    return ObjectResponse(
      status: map['status'] ?? '',
      totalResults: map['totalResults']?.toInt() ?? 0,
      articles: List<ArticleModel>.from(
          map['articles']?.map((x) => ArticleModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ObjectResponse.fromJson(String source) =>
      ObjectResponse.fromMap(json.decode(source));
}
