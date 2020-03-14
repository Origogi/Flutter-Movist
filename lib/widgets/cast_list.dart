import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list/model/models.dart';
import 'package:flutter_list/pages/profile_page.dart';
import 'package:flutter_list/util/util.dart';

class CastList extends StatelessWidget {
  final List<Cast> casts;

  CastList({this.casts});

  final _imageHeight = 140.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _imageHeight + 90,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(index);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                final cast = casts[index];
                return ProfilePage(
                    id: cast.id,
                    name: cast.name,
                    imageUrl: cast.profileUrl,
                    heroID: HeroID.make(casts[index].id, 'cast'));
              }));
            },
            child: Container(
              width: _imageHeight * 0.9,
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: HeroID.make(casts[index].id, 'cast'),
                    child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        width: _imageHeight * 0.7,
                        height: _imageHeight,
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
                            child: FadeInImage(
                              image: NetworkImage(casts[index].profileUrl),
                              fit: BoxFit.cover,
                              placeholder:
                                  AssetImage('assets/images/loading.gif'),
                            ))),
                  ),
                  Text(casts[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.body1),
                  Text(casts[index].character,
                  textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      style: Theme.of(context).textTheme.body2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
