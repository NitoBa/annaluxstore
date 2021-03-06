import 'package:annaluxstore/app/modules/shared/consttants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'AnnaluxStore',
      theme: ThemeData(
        cursorColor: thirdColor,
        fontFamily: "Montserrat",
        primaryColor: primaryColor,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
