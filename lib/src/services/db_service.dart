import 'package:hive/hive.dart';
import 'package:news_universe/src/models/article_model.dart';

class DbService {
  void createArticle({required ArticleModel articleModel}) {
    final articleBox = Hive.box('articlesBox');
    articleBox.add(articleModel);
  }

  List<ArticleModel> getAllArticles() {
    final articlesBox = Hive.box('articlesBox');
    return articlesBox.values.cast<ArticleModel>().toList();
  }

  ArticleModel getArticle({required int index}) {
    final articleBox = Hive.box('articlesBox');
    return articleBox.getAt(index) as ArticleModel;
  }

  void deleteArticle({required int index}) {
    final articleBox = Hive.box('articlesBox');
    articleBox.deleteAt(index);
  }
}
