import 'package:flutter/material.dart';
import 'package:news_universe/src/models/article_model.dart';
import 'package:news_universe/src/repositories/articles_repository.dart';
import 'package:news_universe/src/shared/utils/contantes.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleRepository _articleRepository = ArticleRepository();

  ArticleModel _articleLiked = ArticleModel();

  bool _isLoadingArticle = true;
  bool _isLoadingBussiness = true;
  bool _isLoadingScience = true;
  bool _isLoadingSport = true;

  bool _isLoadingSearch = false;

  int _indexLiked = 0;
  int _currentPageSize = 100;
  int _currentsBusinessPageSize = 100;
  int _currentSciencesPageSize = 100;
  int _currentSportPageSize = 100;

  String _searchInput = "";
  String _sortByValue = "relevancy";
  String _typeValue = "general";
  String _uploadDate = "today";
  String _errorMessage = "";
  String _errorMessageSport = "";
  String _errorMessageBusiness = "";
  String _errorMessageSciences = "";
  String _searchErrorMessage = "";

  final List<ArticleModel> _articles = [];
  final List<ArticleModel> _sports = [];
  final List<ArticleModel> _business = [];
  final List<ArticleModel> _sciences = [];
  final List<ArticleModel> _articlesInFavorites = [];
  final List<ArticleModel> _articlesSearch = [];

  ArticleModel get articleLiked => _articleLiked;

  bool get isLoadingArticle => _isLoadingArticle;
  bool get isLoadingBussiness => _isLoadingBussiness;
  bool get isLoadingScience => _isLoadingScience;
  bool get isLoadingSport => _isLoadingSport;

  bool get isLoadingSearch => _isLoadingSearch;

  int get indexLiked => _indexLiked;
  int get currentPageSize => _currentPageSize;
  int get currentsBusinessPageSize => _currentsBusinessPageSize;
  int get currentSciencesPageSize => _currentSciencesPageSize;
  int get currentSportPageSize => _currentSportPageSize;

  String get searchInput => _searchInput;
  String get sortByValue => _sortByValue;
  String get typeValue => _typeValue;
  String get uploadDate => _uploadDate;
  String get errorMessage => _errorMessage;
  String get errorMessageSport => _errorMessageSport;
  String get errorMessageBusiness => _errorMessageBusiness;
  String get errorMessageSciences => _errorMessageSciences;
  String get searchErrorMessage => _searchErrorMessage;

  List<ArticleModel> get articles => _articles;
  List<ArticleModel> get sports => _sports;
  List<ArticleModel> get business => _business;
  List<ArticleModel> get sciences => _sciences;
  List<ArticleModel> get articlesInFavorites => _articlesInFavorites;
  List<ArticleModel> get articlesSearch => _articlesSearch;

  void setIsLoadingValue({required bool value}) {
    _isLoadingArticle = value;
    notifyListeners();
  }

  void setIsLoadingBussinessValue({required bool value}) {
    _isLoadingBussiness = value;
    notifyListeners();
  }

  void setIsLoadingScienceValue({required bool value}) {
    _isLoadingScience = value;
    notifyListeners();
  }

  void setIsLoadingSportValue({required bool value}) {
    _isLoadingSport = value;
    notifyListeners();
  }

  void setLoadingSearch({required bool value}) {
    _isLoadingSearch = value;
    notifyListeners();
  }

  void setIndexLiked({required int value}) {
    _indexLiked = value;
    notifyListeners();
  }

  void setSortByValue({required String value}) {
    _sortByValue = value;
    notifyListeners();
  }

  void setUploadDate({required String value}) {
    _uploadDate = value;
    notifyListeners();
  }

  void setTypeValue({required String value}) {
    _typeValue = value;
    notifyListeners();
  }

  void setSearchInput({required String value}) {
    if (value.isNotEmpty) {
      _searchInput = value;
    } else {
      _articlesSearch.clear();
    }
    notifyListeners();
  }

  Future<void> searchArticles() async {
    try {
      _articlesSearch.clear();
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'q=$_searchInput', pageSize: 100);
      _articlesSearch.addAll(nextPageItems);
      _isLoadingSearch = false;
      notifyListeners();
    } catch (e) {
      _searchErrorMessage = "No Found";
      _isLoadingSearch = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticles(
      {String? sortBy, String? fromDate, String? toDate}) async {
    try {
      _articles.clear();
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query:
              'sources=$bbcSport,$foxSport,$skySport,$bloomberg,$financialTimes,$businessInsider,$newScientist,$nationalGeographic,$scienceDaily',
          pageSize: _currentPageSize,
          filter: 'from=$fromDate&to=$toDate&sortBy=$sortBy');
      _articles.addAll(nextPageItems);
      _currentPageSize = _currentPageSize + 10;
      _isLoadingArticle = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = catchErrorMessage;
      _isLoadingArticle = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesSport(
      {String? sortBy, String? fromDate, String? toDate}) async {
    try {
      _sports.clear();
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=$bbcSport,$foxSport,$skySport',
          pageSize: _currentSportPageSize,
          filter: 'from=$fromDate&to=$toDate&sortBy=$sortBy');
      _sports.addAll(nextPageItems);
      _currentSportPageSize = _currentSportPageSize + 10;
      _isLoadingSport = false;
      notifyListeners();
    } catch (e) {
      _errorMessageSport = catchErrorMessage;
      _isLoadingSport = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesBusiness(
      {String? sortBy, String? fromDate, String? toDate}) async {
    try {
      _business.clear();
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=$bloomberg,$financialTimes,$businessInsider',
          pageSize: _currentsBusinessPageSize,
          filter: 'from=$fromDate&to=$toDate&sortBy=$sortBy');
      _business.addAll(nextPageItems);
      _currentsBusinessPageSize = _currentsBusinessPageSize + 10;
      _isLoadingBussiness = false;
      notifyListeners();
    } catch (e) {
      _errorMessageBusiness = catchErrorMessage;
      _isLoadingBussiness = false;
      notifyListeners();
    }
  }

  Future<void> fetchArticlesSciences(
      {String? sortBy, String? fromDate, String? toDate}) async {
    try {
      _sciences.clear();
      List<ArticleModel> nextPageItems = await _articleRepository.fetchArticles(
          query: 'sources=$newScientist,$nationalGeographic,$scienceDaily',
          pageSize: _currentSciencesPageSize,
          filter: 'from=$fromDate&to=$toDate&sortBy=$sortBy');
      _sciences.addAll(nextPageItems);
      _currentSciencesPageSize = _currentSciencesPageSize + 10;
      _isLoadingScience = false;
      notifyListeners();
    } catch (e) {
      _errorMessageSciences = catchErrorMessage;
      _isLoadingScience = false;
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
