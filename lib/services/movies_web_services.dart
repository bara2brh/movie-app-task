import 'package:dio/dio.dart';

class MovieWebServices {
  late Dio _dio;

  MovieWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/',
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    _dio = Dio(options);
  }


  Future<List<dynamic>> getAllMovies({int page = 1}) async {
    try {
      Response response = await _dio.get(
        'discover/movie',
        queryParameters: {
          'api_key': '79d374bc7a0287e624400d88454681b6',
          'page': page,
        },
      );
      print(response.data.toString());
      return response.data['results'];
    } catch (e) {
      print('Error fetching movies: ${e.toString()}');
      return [];
    }
  }
}
