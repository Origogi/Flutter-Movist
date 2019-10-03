import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const POSTER_RATIO = 0.7;

  Poster({this.posterUrl, this.height = 100.0});

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = POSTER_RATIO * height;

    return Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 12.0,
      child: Container(
        width: width,
        height: height,
        child: Image.network(
          posterUrl,
          fit: BoxFit.cover,
          width: width,
          height: height,
        ),
      ),
    );
  }
}
