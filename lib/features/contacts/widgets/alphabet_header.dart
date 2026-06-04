import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlphabetHeader extends StatelessWidget {
  final String letter;

  const AlphabetHeader({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 8.h,
      ),
      child: Text(
        letter,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}