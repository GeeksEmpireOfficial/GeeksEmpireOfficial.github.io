import 'dart:ui';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geeksempire_website/categories/ui/MagazineCategories.dart';
import 'package:geeksempire_website/categories/ui/StorefrontCategories.dart';
import 'package:geeksempire_website/dashboard/ui/Dashboard.dart';
import 'package:geeksempire_website/exclusive/ui/CoolGadgets.dart';
import 'package:geeksempire_website/firebase_options.dart';
import 'package:geeksempire_website/private/Privates.dart';
import 'package:geeksempire_website/resources/colors_resources.dart';
import 'package:geeksempire_website/resources/strings_resources.dart';
import 'package:geeksempire_website/search/ui/Search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaEnterpriseProvider(Privates.reCaptchEnterpriseSiteKey)
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
        '/Search': (BuildContext context) => Search(searchQuery: ''),
      },
      onGenerateRoute: (routeSettings) {

        Uri uri = Uri.parse(routeSettings.name ?? "");

        Map<String, dynamic> parameters = {};

        uri.queryParameters.forEach((key, value) {

          parameters[key] = value;

        });

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

        } else if (parameters["searchQuery"] != null) { // Search
          debugPrint("Search Query: ${parameters["searchQuery"].toString().toUpperCase()}");

          //https://geeks-empire-website.web.app/#/Search?searchQuery=Lego
          return MaterialPageRoute(
              builder: (_) => Search(searchQuery: parameters["searchQuery"])
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