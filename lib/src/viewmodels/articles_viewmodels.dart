import 'package:flutter/material.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/repositories/articles_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleRepository _articleRepository = ArticleRepository();

  ArticleModel _articleLiked = ArticleModel();
  bool _isLoadingArticle = true;
  int _indexLiked = 0;
  int _currentPageSize = 100;
  int _currentsBusinessPageSize = 100;
  int _currentSciencesPageSize = 100;
  int _currentSportPageSize = 100;

  String _errorMessage = "";
  String _errorMessageSport = "";
  String _errorMessageBusiness = "";
  String _errorMessageSciences = "";

  final List<ArticleModel> _articles = [];
  final List<ArticleModel> _sports = [];
  final List<ArticleModel> _business = [];
  final List<ArticleModel> _sciences = [];
  final List<ArticleModel> _articlesInFavorites = [];

  ArticleModel get articleLiked => _articleLiked;

  bool get isLoadingArticle => _isLoadingArticle;

  int get indexLiked => _indexLiked;
  int get currentPageSize => _currentPageSize;
  int get currentsBusinessPageSize => _currentsBusinessPageSize;
  int get currentSciencesPageSize => _currentSciencesPageSize;
  int get currentSportPageSize => _currentSportPageSize;

  String get errorMessage => _errorMessage;
  String get errorMessageSport => _errorMessageSport;
  String get errorMessageBusiness => _errorMessageBusiness;
  String get errorMessageSciences => _errorMessageSciences;

  List<ArticleModel> get articles => _articles;
  List<ArticleModel> get sports => _sports;
  List<ArticleModel> get business => _business;
  List<ArticleModel> get sciences => _sciences;
  List<ArticleModel> get articlesInFavorites => _articlesInFavorites;

  void setIndexLiked({required int value}) {
    _indexLiked = value;
    notifyListeners();
  }

  Future<void> fetchArticles() async {
    try {
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query:
              'sources=bbc-sport,fox-sports, sky-sports,bloomberg,financial-times, business-insider, new-scientist,national-geographic, science-daily',
          pageSize: _currentPageSize);
      _articles.addAll(nextPageItems);
      _currentPageSize = _currentPageSize + 10;
      _isLoadingArticle = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Something went wrong\ntry to reload the page...";
      _isLoadingArticle = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesSport() async {
    try {
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=bbc-sport,fox-sports, sky-sports',
          pageSize: _currentSportPageSize);
      _sports.addAll(nextPageItems);
      _currentSportPageSize = _currentSportPageSize + 10;
      _isLoadingArticle = false;
      notifyListeners();
    } catch (e) {
      _errorMessageSport = "Something went wrong\ntry to reload the page...";
      _isLoadingArticle = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesBusiness() async {
    try {
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=bloomberg,financial-times, business-insider',
          pageSize: _currentsBusinessPageSize);
      _business.addAll(nextPageItems);
      _currentsBusinessPageSize = _currentsBusinessPageSize + 10;
      _isLoadingArticle = false;
      notifyListeners();
    } catch (e) {
      _errorMessageBusiness = "Something went wrong\ntry to reload the page...";
      _isLoadingArticle = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesSciences() async {
    try {
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=new-scientist,national-geographic, science-daily',
          pageSize: _currentSciencesPageSize);
      _sciences.addAll(nextPageItems);
      _currentSciencesPageSize = _currentSciencesPageSize + 10;
      _isLoadingArticle = false;
      notifyListeners();
    } catch (e) {
      _errorMessageSciences = "Something went wrong\ntry to reload the page...";
      _isLoadingArticle = false;
      notifyListeners();
    }
  }

  void addInFavorite({required ArticleModel articleModel}) {
    try {
      _articleRepository.addFavorite(articleModel: articleModel);
      _articleLiked = articleModel;
      _articlesInFavorites.add(articleModel);
      notifyListeners();
    } catch (e) {
      throw Exception('Exeption: $e');
    }
  }

  void getAllFavorites() {
    try {
      _articlesInFavorites.clear();
      final itemsliked = _articleRepository.getAllFavorites();
      _articlesInFavorites.addAll(itemsliked);
    } catch (e) {
      throw Exception('Exeption: $e');
    }
  }

  void getFavorite({required int index}) {
    try {
      final itemLiked = _articleRepository.getFavorite(index: index);
      _articleLiked = itemLiked;
    } catch (e) {
      throw Exception('Exeption: $e');
    }
  }

  void deleteArticle() {
    try {
      _articleRepository.deleteFavorite(index: indexLiked);
      _articlesInFavorites.removeAt(_indexLiked);
      _articleLiked = ArticleModel();
      _indexLiked = 0;
      notifyListeners();
    } catch (e) {
      throw Exception('Exeption: $e');
    }
  }
}
