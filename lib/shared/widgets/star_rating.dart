import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarRating extends StatefulWidget {
  final String label;
  final Function(int) onRatingChanged;
  final int initialRating;

  const StarRating({
    Key? key,
    required this.label,
    required this.onRatingChanged,
    this.initialRating = 0,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() => _rating = index + 1);
                widget.onRatingChanged(index + 1);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: Icon(
                  index < _rating ? Icons.star : Icons.star_outline,
                  color: const Color(0xFFFDB022),
                  size: 28.sp,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
