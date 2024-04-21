import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel_website/exclusive/gadgets/CoolGadgets.dart';
import 'package:sachiel_website/firebase_options.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsResources.geeksEmpire(),
      color: ColorsResources.black,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      home: const CoolGadgets(),
      routes: <String, WidgetBuilder> {
        '/Home': (BuildContext context) => const CoolGadgets(),
        '/CoolGadgets': (BuildContext context) => const CoolGadgets(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) {

              return const CoolGadgets();
            }
        );
      }
  ));

}