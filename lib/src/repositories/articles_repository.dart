import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/services/api_service.dart';
import 'package:news_universe/src/services/db_service.dart';

class ArticleRepository {
  final ApiService _apiService = ApiService();
  final DbService _dbService = DbService();

  Future<List<ArticleModel>> fetchArticles(
      {required String query, required int pageSize}) async {
    try {
      final itemsData =
          await _apiService.fetchAllArticles(query: query, pageSize: pageSize);
      final articles = List<ArticleModel>.from(
        itemsData.articles.map((item) {
          return item;
        }),
      );
      return articles;
    } catch (e) {
      throw Exception('Failed to get items');
    }
  }

  void addFavorite({required ArticleModel articleModel}) {
    return _dbService.createArticle(articleModel: articleModel);
  }

  List<ArticleModel> getAllFavorites() {
    return _dbService.getAllArticles();
  }

  ArticleModel getFavorite({required int index}) {
    return _dbService.getArticle(index: index);
  }

  void deleteFavorite({required int index}) {
    _dbService.deleteArticle(index: index);
  }
}
