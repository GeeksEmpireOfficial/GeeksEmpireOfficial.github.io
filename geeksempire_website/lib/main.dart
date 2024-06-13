import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel_website/categories/ui/MagazineCategories.dart';
import 'package:sachiel_website/categories/ui/StorefrontCategories.dart';
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
        '/MagazineCategories': (BuildContext context) => MagazineCategories(postId: 0),
        '/StorefrontCategories': (BuildContext context) => StorefrontCategories(productId: 0),
      },
      onGenerateRoute: (routeSettings) {

        Uri uri = Uri.parse(routeSettings.name ?? "");

        Map<String, dynamic> parameters = {};

        uri.queryParameters.forEach((key, value) {

          parameters[key] = value;

        });

        print(parameters["productId"]);
        print(parameters["postId"]);

        if (parameters["productId"] != null) { // Storefront
          debugPrint("Product Id: ${parameters["productId"].toString().toUpperCase()}");

          //https://geeks-empire-website.web.app/#/StorefrontCategories?productId=[]
          return MaterialPageRoute(
              builder: (_) => StorefrontCategories(productId: int.parse(parameters["productId"]))
          );

        } else if (parameters["postId"] != null) { // Magazine
          debugPrint("Post Id: ${parameters["postId"].toString().toUpperCase()}");

          //https://geeks-empire-website.web.app/#/MagazineCategories?postId=[]
          return MaterialPageRoute(
              builder: (_) => MagazineCategories(postId: int.parse(parameters["postId"]))
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