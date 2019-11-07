import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  final String imageUrl;
  Poster({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: 130,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(color: Colors.black54, offset: Offset(0, 4), blurRadius: 6)
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/images/loading.gif'),
          ),
        ));
  }
}
