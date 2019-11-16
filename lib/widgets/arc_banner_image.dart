import 'package:flutter/cupertino.dart';

class ArcBannerImage extends StatelessWidget {
  final String imageUrl;
  ArcBannerImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    var sreenWidth = MediaQuery.of(context).size.width;
    
    dynamic image;

    if (imageUrl.isEmpty) {
      image = Image.asset('assets/images/loading.gif', fit: BoxFit.fill,);
    } else {
      image = FadeInImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/images/loading.gif'),
      );
    }

    return ClipPath(
        clipper: ArcClipper(),
        child: Container(
          width: sreenWidth,
          height: 230,
          child: image,
        ));
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
