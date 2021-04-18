import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/wrapper.dart';
import 'package:tracker/screens/wrapper.dart';
import 'services/auth.dart';
import 'constants/tokens/colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      Provider<AuthBase>(
        create: (context) => Auth(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Maximize your productivity on your homestead by joining now',
          theme: ThemeData(
            primarySwatch: colorCustomGrey,
            bottomAppBarColor: colorCustomGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonTheme: ButtonThemeData(
              minWidth: 120,
              height: 40,
              buttonColor: colorCustomOrange,
              shape: RoundedRectangleBorder(),
              textTheme: ButtonTextTheme.accent,
            ),
            fontFamily: 'Roboto',
          ),
          home: Wrapper(),
        ));
  }
}
