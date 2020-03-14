import 'package:flutter/material.dart';
import 'package:flutter_list/network/api.dart';
import 'package:flutter_list/pages/home_page.dart';
import 'package:flutter_list/state/states.dart';

import 'package:provider/provider.dart';

import 'locale/delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => FavoriteState()),
      ChangeNotifierProvider(create: (_) => ThemeState()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Provider.of<ThemeState>(context).themeData;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomePage(),
      supportedLocales: [const Locale('en', 'US'), const Locale('ko', 'KR')],
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");

            MovieDBApi.localeCode =
                '${supportedLocale.languageCode}-${supportedLocale.countryCode}';
            return supportedLocale;
          }
        }
        MovieDBApi.localeCode =
            '${supportedLocales.first.languageCode}-${supportedLocales.first.countryCode}';

        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },
    );
  }


}
