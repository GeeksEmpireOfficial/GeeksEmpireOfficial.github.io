import 'package:flutter/material.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';

class CoolGadgets extends StatefulWidget {

  const CoolGadgets({Key? key}) : super(key: key);

  @override
  State<CoolGadgets> createState() => CoolGadgetsState();
}
class CoolGadgetsState extends State<CoolGadgets> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
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
            home: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: ColorsResources.black,
                body: Stack(
                    children: [



                    ]
                )
            )
        )
    );
  }

}