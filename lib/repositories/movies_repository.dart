import '../services/movies_web_services.dart';

class MovieRepository {
  final MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);

  Future<List<dynamic>> fetchMovies() async {
    return await movieWebServices.getAllMovies();
  }
}
