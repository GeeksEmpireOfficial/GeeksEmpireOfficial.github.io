import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel_website/categories/ui/Categories.dart';
import 'package:sachiel_website/dashboard/ui/Dashboard.dart';
import 'package:sachiel_website/exclusive/ui/CoolGadgets.dart';
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
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        },
      ),
      home: const Dashboard(),
      routes: <String, WidgetBuilder> {
        '/Home': (BuildContext context) => const Dashboard(),
        '/CoolGadgets': (BuildContext context) => const CoolGadgets(),
        '/Categories': (BuildContext context) => Categories(productId: 0),
      },
      onGenerateRoute: (routeSettings) {

        Uri uri = Uri.parse(routeSettings.name ?? "");

        Map<String, dynamic> parameters = {};

        uri.queryParameters.forEach((key, value) {

          parameters[key] = value;

        });

        if (parameters["productId"].toString().isNotEmpty) {
          debugPrint("Product Id: ${parameters["productId"].toString().toUpperCase()}");

          //https://geeks-empire-website.web.app/#/Categories?productId=[]
          return MaterialPageRoute(
              builder: (_) => Categories(productId: int.parse(parameters["productId"]))
          );

        } else {

          return MaterialPageRoute(
              builder: (_) => const Dashboard()
          );

        }

      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) {

              return const Dashboard();
            }
        );
      }
  ));

}