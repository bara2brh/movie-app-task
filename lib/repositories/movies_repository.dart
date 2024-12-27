import '../model/movies.dart';
import '../services/movies_web_services.dart';
class MovieRepository {
  final MovieWebServices movieWebServices;

  MovieRepository(this.movieWebServices);

  // Fetch movies with pagination
  Future<Movies> fetchMovies({int page = 1}) async {
    // Fetch raw movie data from the service
    final List<dynamic> movieList = await movieWebServices.getAllMovies(page: page);

    // Map the fetched data into a Movies object
    return Movies(
      page: page,
      results: movieList,
      totalPages: movieList.length > 0 ? 1 : 0, // Adjust this according to your API response
      totalResults: movieList.length,
    );
  }
}
