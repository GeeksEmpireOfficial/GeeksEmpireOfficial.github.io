import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/ui/Dashboard.dart';
import 'package:sachiel_website/exclusive/gadgets/CoolGadgets.dart';
import 'package:sachiel_website/firebase_options.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Dashboard(),
      routes: <String, WidgetBuilder> {
        '/Home': (BuildContext context) => const Dashboard(),
        '/CoolGadgets': (BuildContext context) => const CoolGadgets(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) {

              return const Dashboard();
            }
        );
      }
  )
  );

}