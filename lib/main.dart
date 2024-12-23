import 'package:flutter/material.dart';
import 'package:movie_app_project/view/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        home:  HomeScreen(),
      ),
    );
  }
}
