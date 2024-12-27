import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatefulWidget {
  final movie;
  const MovieDetailsScreen({super.key,  required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${widget.movie['poster_path']}',
                   ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
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

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  // Movie Title and Metadata
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
                    '${'Release Date : '+widget.movie['release_date']} | Language : '+widget.movie["original_language"].toUpperCase() ,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Rating Section
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
                        ), onRatingUpdate: (double value) {  },

                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${widget.movie['vote_count']} votes)',
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Summary Section
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

                  // Director and Stars

                  const SizedBox(height: 30),

                  // Watch Movie Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add To Favorite",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
