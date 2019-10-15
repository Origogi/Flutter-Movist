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

    return Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              width: width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, 4),
                        blurRadius: 6)
                  ]),
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    posterUrl,
                    fit: BoxFit.cover,
                  )),
            );
  }
}
