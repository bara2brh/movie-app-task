import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app_project/view/components/movie_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';

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
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);
    moviesCubit.fetchMovies();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          _buildCarousel(),
          _buildSectionHeading('Find Your \nFavorite Movie!'),
          _buildSearchBar(),
          _buildSectionHeading('Movies List'),
          BlocBuilder<MoviesCubit, MoviesState>(
            builder: (context, state) {
              if (state is MoviesLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator(color: Colors.redAccent,)),
                );
              } else if (state is MoviesLoaded) {
                return _buildMovieGrid(state.movies);
              } else if (state is MoviesError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text(state.message)),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(child: Text("No Movies Available",style: TextStyle(color: Colors.white,fontSize: 18,),)),
              );
            },
          ),
        ],
      ),
    );
  }
  // Builds the carousel
  SliverToBoxAdapter _buildCarousel() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
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
                      fit: BoxFit.fitHeight,
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
            style: const TextStyle(
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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

   SliverGrid _buildMovieGrid(List<dynamic> movies) {
     return SliverGrid(
       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         childAspectRatio: 0.75,
       ),
       delegate: SliverChildBuilderDelegate(
             (BuildContext context, int index) {
           final movie = movies[index];
           return MovieCard(
             imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
             title: movie['title'],
             rating: movie['vote_average'] / 2,
           );
         },
         childCount: movies.length,
       ),
     );
   }

SliverToBoxAdapter _buildHeader() {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 20),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/pfp.png'),
          ),
          const SizedBox(width: 10,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back', style: TextStyle(
                color: Colors.redAccent,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              ),
              Text('Bara Hashlamoon',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Spacer(),
          IconButton(onPressed: () {},
              icon: const Icon(
                Icons.favorite_rounded, color: Colors.redAccent, size: 25,))
        ],
      ),
    ),
  );
}
}
