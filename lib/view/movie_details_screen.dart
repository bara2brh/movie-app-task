import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDetailsScreen extends StatefulWidget {
  final movie;
  final bool wasFavorite;

  const MovieDetailsScreen(
      {super.key, required this.movie, required this.wasFavorite});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  List<dynamic> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesString = prefs.getString('favorites');
    if (favoritesString != null) {
      setState(() {
        favoriteMovies = jsonDecode(favoritesString);
      });
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('favorites', jsonEncode(favoriteMovies));
  }

  void addToFavorites(movie) {
    setState(() {
      favoriteMovies.add(movie);
      saveFavorites();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          movie['title'] + " added to favorites!",
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.redAccent.withOpacity(0.9),
        showCloseIcon: true,
      ),
    );
  }

  void removeFromFavorites(int movieId) {
    setState(() {
      favoriteMovies.removeWhere((m) => m['id'] == movieId);
      saveFavorites();
    });
  }

  bool isFavorite(int id) {
    return favoriteMovies.any((m) => m['id'] == id);
  }

  @override
  Widget build(BuildContext context) {
    bool favorite = isFavorite(widget.movie['id']);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${widget.movie['poster_path']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.0),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  Text(
                    widget.movie['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${'Release Date : ' + widget.movie['release_date']} | Language : ' +
                        widget.movie["original_language"].toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: widget.movie['vote_average'] / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 20,
                        unratedColor: Colors.white70,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.redAccent,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${widget.movie['vote_count']} votes)',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ReadMoreText(
                    widget.movie['overview'],
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                    trimMode: TrimMode.Line,
                    isExpandable: true,
                    trimLines: 2,
                    colorClickableText: Colors.redAccent,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Read less',
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (favorite) {
                          removeFromFavorites(widget.movie['id']);
                        } else {
                          addToFavorites(widget.movie);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: favorite
                            ? Colors.grey
                            : Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        favorite ? "Remove From Favorite" : "Add To Favorite",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
