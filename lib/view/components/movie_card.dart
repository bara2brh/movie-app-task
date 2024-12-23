import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: 300.w,
        height: 250,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/poster1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildText('Movie Name', fontSize: 18.sp, fontWeight: FontWeight.bold),
                  _buildText('Rating: 10/10', fontSize: 16.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String text, {required double fontSize, FontWeight fontWeight = FontWeight.normal}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
