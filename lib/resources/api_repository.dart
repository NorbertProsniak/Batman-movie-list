import 'package:next_app_zadanie/models/movie_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<MovieModel> fetchMovieList() {
    return _provider.fetchMovieList();
  }
}

class NetworkError extends Error {}