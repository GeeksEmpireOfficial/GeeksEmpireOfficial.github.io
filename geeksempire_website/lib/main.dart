import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel_website/exclusive/gadgets/CoolGadgets.dart';
import 'package:sachiel_website/firebase_options.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
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