import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatefulWidget {

  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isExpanded = false;
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/poster1.jpg'),
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
                    "Spider-Man: No Way Home",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Action, Adventure, Fantasy  |  English  |  2h 15m",
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
                        initialRating: 4.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 20,
                        unratedColor: Colors.grey,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.redAccent,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(1M)",
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
                    "With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. "
                     "When a spell goes wrong, dangerous foes from other worlds start to appear...",
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
                  const Text(
                    "Director: Jon Watts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Stars: Tom Holland, Zendaya, Benedict Cumberbatch",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                  ),

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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
