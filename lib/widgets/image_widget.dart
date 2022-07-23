import 'package:aams_fyp/widgets/shimmer_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String photoURL;
  final String displayName;
  final Color color;
  final Color textColor;
  final double fontSize;
  const ImageWidget({
    Key? key,
    required this.displayName,
    required this.photoURL,
    required this.color,
    required this.textColor,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(128),
      child: CachedNetworkImage(
        imageUrl: photoURL,
        placeholder: (context, url) => const ShimmerWidget(),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            // color: Colors.white,
            // color: Color(0xff009241),
          ),
          child: Center(
            child: Text(
              displayName[0].toUpperCase(),
              style: TextStyle(
                fontFamily: "NotoSans",
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
        fit: BoxFit.cover,
        // color: color,
        colorBlendMode: BlendMode.srcATop,
      ),
    );
  }
}
