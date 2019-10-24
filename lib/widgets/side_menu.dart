import 'package:flutter/material.dart';
import 'package:flutter_list/state/states.dart';
import 'package:provider/provider.dart';


class SideMenu extends StatelessWidget {
  final List<Color> colors = [Colors.white, Color(0xff242248), Colors.black];
  final List<Color> borders = [Colors.black, Colors.white, Colors.white];
  final List<String> themes = ['Light', 'Dark', 'Amoled'];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Drawer(
      child: Container(
        color: themeData.backgroundColor,
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Theme',
                        style: themeData.textTheme.title),
                  ],
                ),
                subtitle: SizedBox(
                  height: 100,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 2, color: borders[index]),
                                        color: colors[index]),
                                  ),
                                ),
                                Text(themes[index], style: themeData.textTheme.caption)
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      print("tap : " + index.toString());
                                      Provider.of<ThemeState>(context).changeTheme(themes[index]);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Provider.of<ThemeState>(context).themeKey == themes[index]
                                          ? Icon(Icons.done,
                                              color: Theme.of(context).accentColor)
                                          : Container(),
                                    ),
                                  ),
                                ),
                                Text(themes[index], style: themeData.textTheme.caption)
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
