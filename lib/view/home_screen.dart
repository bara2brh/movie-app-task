import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app_project/view/components/movie_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_project/view/favorite_movies_screen.dart';
import '../cubit/favorites_cubit.dart';
import '../cubit/movies_cubit.dart';
import '../cubit/movies_state.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> bannerImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.webp',
    'assets/images/banner4.jpg',
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);
    moviesCubit.fetchMovies(isPagination: false);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);
    if (moviesCubit.searchQuery.isEmpty &&
        _scrollController.position.atEdge &&
        _scrollController.position.pixels > 0) {
      if (!(moviesCubit.state is MoviesLoading) || !(moviesCubit.state as MoviesLoading).isPagination) {
        print('Bottom reached, fetching more movies...');
        moviesCubit.fetchMovies(isPagination: true);
      }
    }
  }





  @override
  Widget build(BuildContext context) {
    final moviesCubit = BlocProvider.of<MoviesCubit>(context);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (moviesCubit.searchQuery.isEmpty &&
              scrollNotification is ScrollEndNotification &&
              scrollNotification.metrics.extentAfter == 0) {
            if (moviesCubit.state is! MoviesLoading || !(moviesCubit.state as MoviesLoading).isPagination) {
              moviesCubit.fetchMovies(isPagination: true);
            }
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            _buildHeader(),
            _buildCarousel(),
            _buildSectionHeading('Find Your \nFavorite Movie!'),
            _buildSearchBar(context),
            _buildSectionHeading('Movies List'),
            BlocBuilder<MoviesCubit, MoviesState>(
              builder: (context, state) {
                if (state is MoviesLoading && !state.isPagination) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator(color: Colors.redAccent)),
                  );
                } else if (state is MoviesLoaded) {
                  final filteredMovies = state.movies;
                  if (filteredMovies.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          "No Results Found",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    );
                  }
                  return _buildMovieGrid(filteredMovies);
                } else if (state is MoviesError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message, style: const TextStyle(color: Colors.redAccent, fontSize: 18)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => BlocProvider.of<MoviesCubit>(context).fetchMovies(),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                            child: const Text('Retry' , style: TextStyle(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              },
            ),
          ],
        ),
      ),

    );
  }

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

  SliverToBoxAdapter _buildSearchBar(BuildContext context) {
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
          child: Row(
            children: [
              const Expanded(
                child: Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextField(
                  controller: BlocProvider.of<MoviesCubit>(context).searchController,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Movies...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: BlocBuilder<MoviesCubit, MoviesState>(
                      builder: (context, state) {
                        return BlocProvider.of<MoviesCubit>(context)
                            .searchQuery
                            .isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            BlocProvider.of<MoviesCubit>(context).clearSearchQuery();
                          },
                        )
                            : const SizedBox();
                      },
                    ),
                  ),
                  onChanged: (query) {
                    BlocProvider.of<MoviesCubit>(context).updateSearchQuery(query);
                  },
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
          if (index == movies.length) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }
          final movie = movies[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      MovieDetailsScreen(movie: movie, wasFavorite: false),
                ),
              );
            },
            child: MovieCard(
              movie: movie,
            ),
          );
        },
        childCount: movies.length+1,
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
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back', style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                )),
                Text('Bara Hashlamoon',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const Spacer(),
            IconButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<FavoritesCubit>(
                        create: (context) => FavoritesCubit()..loadFavorites(),
                      ),
                    ],
                    child: FavoritesScreen(),
                  ),
                ),
              );

            } ,
                icon: const Icon(
                  Icons.favorite_rounded, color: Colors.redAccent, size: 25,)),
          ],
        ),
      ),
    );
  }
}
