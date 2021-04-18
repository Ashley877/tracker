import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'tokens/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorCustomGrey,
      child: Center(
        child: SpinKitFadingCircle(
          color: colorCustomOrange,
          size: 50.0,
        ),
      ),
    );
  }
}
