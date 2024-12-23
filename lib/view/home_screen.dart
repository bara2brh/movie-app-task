import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app_project/view/components/movie_card.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final List<String> bannerImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.webp',
    'assets/images/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Carousel section
          _buildCarousel(),

          // Heading for the movie section
          _buildSectionHeading('Find Your \nFavorite Movie!'),

          // Search bar section
          _buildSearchBar(),

          // Movies List section heading
          _buildSectionHeading('Movies List'),

          // Grid of Movie Cards
          _buildMovieGrid(),
        ],
      ),
    );
  }

  // Builds the carousel
  SliverToBoxAdapter _buildCarousel() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 0),
        child: ExpandableCarousel(
          options: ExpandableCarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
          ),
          items: bannerImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSectionHeading(String text) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Movies...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverGrid _buildMovieGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 0.75,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return const MovieCard();
        },
        childCount: 5,
      ),
    );
  }
}
