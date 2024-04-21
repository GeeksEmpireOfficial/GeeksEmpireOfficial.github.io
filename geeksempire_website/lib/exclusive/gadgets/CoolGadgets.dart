import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/exclusive/data/ProductDataStructure.dart';
import 'package:sachiel_website/exclusive/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

class CoolGadgets extends StatefulWidget {

  final String coolGadgetTag = "5408";

  const CoolGadgets({Key? key}) : super(key: key);

  @override
  State<CoolGadgets> createState() => _CoolGadgetsState();
}
class _CoolGadgetsState extends State<CoolGadgets> {

  Endpoints endpoints = Endpoints();

  Widget contentPlaceholder = Container();

  @override
  void initState() {
    super.initState();

    retrieveCoolGadgets();

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
                backgroundColor: ColorsResources.premiumLight,
                body: SizedBox(
                  height: 137,
                  width: double.maxFinite,
                  child: contentPlaceholder
                )
            )
        )
    );
  }

  Future retrieveCoolGadgets() async {

    final coolGadgetsResponse = await http.get(Uri.parse(endpoints.productsByTag(widget.coolGadgetTag)));

    final coolGadgetsJson = List.from(jsonDecode(coolGadgetsResponse.body));

    prepareCoolGadgets(coolGadgetsJson);

  }

  void prepareCoolGadgets(coolGadgetsJson) {

    List<Widget> coolGadgetsList = [];

    for (var element in coolGadgetsJson) {

      ProductDataStructure productDataStructure = ProductDataStructure(element);
      debugPrint('Cool Gadget Json: ${productDataStructure.productId()}');

      coolGadgetsList.add(itemCoolGadgets(productDataStructure));

    }

     setState(() {

       contentPlaceholder = ListView(
         padding: const EdgeInsets.only(left: 37, right: 37),
         scrollDirection: Axis.horizontal,
         physics: const BouncingScrollPhysics(),
         children: coolGadgetsList
       );

     });

  }

  Widget itemCoolGadgets(ProductDataStructure productDataStructure) {

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
          height: 119,
          width: 379,
          child: Padding(
            padding: const EdgeInsets.only(right: 19),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(11)),
              child: Material(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: ColorsResources.premiumDarkTransparent,
                      splashFactory: InkRipple.splashFactory,
                      onTap: () async {

                        launchUrl(Uri.parse(productDataStructure.productLink()));

                      },
                      child: Row(
                          children: [

                            SizedBox(
                                height: 119,
                                width: 119,
                                child: WidgetMask(
                                    blendMode: BlendMode.srcIn,
                                    childSaveLayer: true,
                                    mask: Image.network(
                                        productDataStructure.productImage(),
                                        fit: BoxFit.cover
                                    ),
                                    child: Image(
                                      image: AssetImage("assets/squircle_shape.png"),
                                    ),
                                )
                            ),

                            Expanded(
                                child: Text(
                                  productDataStructure.productName(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: ColorsResources.premiumDark,
                                      fontSize: 15
                                  ),
                                )
                            )

                          ]
                      )
                  )
              )
            )
          )
      )
    );
  }

}