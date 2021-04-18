import 'package:flutter/material.dart';

Map<int, Color> myGrey = {
  50: Color.fromRGBO(226, 227, 228, .1),
  100: Color.fromRGBO(226, 227, 228, .2),
  200: Color.fromRGBO(226, 227, 228, .3),
  300: Color.fromRGBO(226, 227, 228, .4),
  400: Color.fromRGBO(226, 227, 228, .5),
  500: Color.fromRGBO(226, 227, 228, .6),
  600: Color.fromRGBO(226, 227, 228, .7),
  700: Color.fromRGBO(226, 227, 228, .8),
  800: Color.fromRGBO(226, 227, 228, .9),
  900: Color.fromRGBO(226, 227, 228, 1),
};

MaterialColor colorCustomGrey = MaterialColor(0xFFE2E3E4, myGrey);

Map<int, Color> myOrange = {
  50: Color.fromRGBO(205, 100, 14, .1),
  100: Color.fromRGBO(205, 100, 14, .2),
  200: Color.fromRGBO(205, 100, 14, .3),
  300: Color.fromRGBO(205, 100, 14, .4),
  400: Color.fromRGBO(205, 100, 14, .5),
  500: Color.fromRGBO(205, 100, 14, .6),
  600: Color.fromRGBO(205, 100, 14, .7),
  700: Color.fromRGBO(205, 100, 14, .8),
  800: Color.fromRGBO(205, 100, 14, .9),
  900: Color.fromRGBO(205, 100, 14, 1),
};

MaterialColor colorCustomOrange = MaterialColor(0xFFCD640E, myOrange);

Map<int, Color> fadedOrange = {
  50: Color.fromRGBO(234, 173, 123, .1),
  100: Color.fromRGBO(234, 173, 123, .2),
  200: Color.fromRGBO(234, 173, 123, .3),
  300: Color.fromRGBO(234, 173, 123, .4),
  400: Color.fromRGBO(234, 173, 123, .5),
  500: Color.fromRGBO(234, 173, 123, .6),
  600: Color.fromRGBO(234, 173, 123, .7),
  700: Color.fromRGBO(234, 173, 123, .8),
  800: Color.fromRGBO(234, 173, 123, .9),
  900: Color.fromRGBO(234, 173, 123, 1),
};

MaterialColor secondaryOrange = MaterialColor(0xFFE2E3E4, fadedOrange);

Map<int, Color> secondaryGrey = {
  50: Color.fromRGBO(177, 175, 170, .1),
  100: Color.fromRGBO(177, 175, 170, .2),
  200: Color.fromRGBO(177, 175, 170, .3),
  300: Color.fromRGBO(177, 175, 170, .4),
  400: Color.fromRGBO(177, 175, 170, .5),
  500: Color.fromRGBO(177, 175, 170, .6),
  600: Color.fromRGBO(177, 175, 170, .7),
  700: Color.fromRGBO(177, 175, 170, .8),
  800: Color.fromRGBO(177, 175, 170, .9),
  900: Color.fromRGBO(177, 175, 170, 1),
};

MaterialColor secondGrey = MaterialColor(0xFFB1AFAA, secondaryGrey);
