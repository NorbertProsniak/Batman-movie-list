import 'package:dio/dio.dart';
import 'package:next_app_zadanie/models/movie_model.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _url = 'http://www.omdbapi.com/?s=Batman&page=1&apikey=746c0f08';

  //405ace12

  Future<MovieModel> fetchMovieList() async {
    try {
      Response response = await _dio.get(_url);
      return MovieModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MovieModel.withError("Data not found / Connection issue");
    }
  }
}
