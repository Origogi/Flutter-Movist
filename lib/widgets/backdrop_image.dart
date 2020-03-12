import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackDropImage extends StatelessWidget {
  final String imageUrl;

  BackDropImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {

    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: FadeInImage(
        width: double.infinity,
        height: 200,
        image: NetworkImage(imageUrl),
        fit:  BoxFit.cover,
        placeholder: AssetImage('assets/images/loading.gif'),
      ),
    );

  }
}
