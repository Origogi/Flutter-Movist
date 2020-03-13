import 'dart:async';  

import 'package:flutter/material.dart';
import 'package:flutter_list/locale/translations.dart';

class TranslationsDelegate extends LocalizationsDelegate<Translations> {  
  const TranslationsDelegate();  
  
  @override  
  bool isSupported(Locale locale) => ['ko', 'en'].contains(locale.languageCode);
  
  @override  
  Future<Translations> load(Locale locale) async {  
    Translations localizations = new Translations(locale);  
  await localizations.load();  
  
  print("Load ${locale.languageCode}");  
  
  return localizations;  
  }  
  
  @override  
  bool shouldReload(TranslationsDelegate old) => false;  
}