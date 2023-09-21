import 'package:flutter/material.dart';
import 'package:my_movies/models/tmdb/tmdb-api-interface.dart';

class HomeScreenModel extends ChangeNotifier {
  int _page = 1;
  int? _genre;
  int _totalPages = 0;

  int get page {
    return _page;
  }

  int? get genre {
    return _genre;
  }

  set page(int nextPage) {
    _page = nextPage;
    notifyListeners();
  }

  set genre(int? nextGenre) {
    _genre = nextGenre;
    _page = 1;
    notifyListeners();
  }

  Future<List<dynamic>> getMoviesList({int? page = 1, int? genre}) async {
    var request =
        await TmdbApiInterface().getMoviesList(page: _page, genre: _genre);

    _totalPages = request['total_pages'];

    return request['results'];
  }

  void nextPage() {
    if (page < _totalPages) {
      page += 1;
    }
  }

  void backPage() {
    if (page > 1) {
      page -= 1;
    }
  }
}
