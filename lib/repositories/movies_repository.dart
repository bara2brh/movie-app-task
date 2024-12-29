import '../model/movies.dart';
import '../services/movies_web_services.dart';
class MovieRepository {
  final MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);


  Future<Movies> fetchMovies({int page = 1}) async {
    final List<dynamic> movieList = await movieWebServices.getAllMovies(page: page);

    return Movies(
      page: page,
      results: movieList,
      totalPages: movieList.isNotEmpty ? 100 : 0,
      totalResults: movieList.length,
    );
  }

}
