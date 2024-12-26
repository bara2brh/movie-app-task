import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_project/repositories/movies_repository.dart';
import 'package:movie_app_project/services/movies_web_services.dart';
import 'package:movie_app_project/view/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app_project/view/movie_details_screen.dart';

import 'cubit/movies_cubit.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  late MovieRepository movieRepository;

   MyApp({super.key}){
     movieRepository = MovieRepository(MovieWebServices());
   }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 810),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0C0F14),
          useMaterial3: true,
        ),
        home: BlocProvider<MoviesCubit>(
          create: (context) => MoviesCubit(movieRepository),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
