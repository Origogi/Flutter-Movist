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
          colors: [Colors.black, Colors.transparent],
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

    // return Column(
    //   children: <Widget>[
    //     Stack(
    //       children: <Widget>[
    //         FadeInImage(
    //           width: double.infinity,
    //           height: 300,
    //           image: NetworkImage(imageUrl),
    //           fit: BoxFit.cover,
    //           placeholder: AssetImage('assets/images/loading.gif'),
    //         ),
    //         Container(
    //           decoration: BoxDecoration(
    //               color: Colors.white,
    //               gradient: LinearGradient(
    //                   begin: FractionalOffset.bottomCenter,
    //                   end: FractionalOffset.topCenter,
    //                   colors: [
    //                     theme.backgroundColor,
    //                     theme.backgroundColor.withOpacity(0.3),
    //                     theme.backgroundColor.withOpacity(0.2),
    //                     theme.backgroundColor.withOpacity(0.1),
    //                   ],
    //                   stops: [
    //                     0.0,
    //                     0.25,
    //                     0.5,
    //                     0.75
    //                   ])),
    //         )
    //       ],
    //     ),

    //   ],
    // );
  }
}
