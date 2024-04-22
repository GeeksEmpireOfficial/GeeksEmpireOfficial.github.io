import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/exclusive/data/ProductDataStructure.dart';
import 'package:sachiel_website/exclusive/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_mask/widget_mask.dart';

// <iframe src="https://geeks-empire-website.web.app/#/CoolGadgets" title="Geeks Empire - Cool Gadgets" loading="lazy" style="border:none;" width="100%" height="137px" />
// <object type="text/html" data="https://geeks-empire-website.web.app/#/CoolGadgets" style="width:100%; height:137px; border:none;"> <p></p> </object>
class CoolGadgets extends StatefulWidget {

  final String coolGadgetTag = "5408";

  const CoolGadgets({Key? key}) : super(key: key);

  @override
  State<CoolGadgets> createState() => _CoolGadgetsState();
}
class _CoolGadgetsState extends State<CoolGadgets> with TickerProviderStateMixin {

  Endpoints endpoints = Endpoints();

  Widget contentPlaceholder = Container();

  late Animation<double> scaleAnimation;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    Navigator.pop(context);

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    retrieveCoolGadgets();

  }

  @override
  void dispose() {
    super.dispose();

    BackButtonInterceptor.remove(aInterceptor);

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorsResources.premiumLight,
            body: Container(
                height: 137,
                alignment: Alignment.center,
                child: SizedBox(
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

      coolGadgetsList.add(itemCoolGadgets(productDataStructure, AnimationController(vsync: this,
          duration: const Duration(milliseconds: 777),
          reverseDuration: const Duration(milliseconds: 333),
          animationBehavior: AnimationBehavior.preserve)));

    }

    coolGadgetsList.shuffle();

     setState(() {

       contentPlaceholder = ListView(
         padding: const EdgeInsets.only(left: 37, right: 37),
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         physics: const BouncingScrollPhysics(),
         children: coolGadgetsList
       );

     });

  }

  Widget itemCoolGadgets(ProductDataStructure productDataStructure, AnimationController animationController) {

    return Align(
      alignment: Alignment.centerLeft,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 1.013)
            .animate(CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut
        )),
        child: SizedBox(
            height: 119,
            width: 379,
            child: Padding(
                padding: const EdgeInsets.only(right: 31),
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(11)),
                    child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  ColorsResources.premiumLight,
                                  ColorsResources.white,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.centerRight
                            )
                        ),
                        child: Material(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: ColorsResources.white,
                                splashFactory: InkRipple.splashFactory,
                                onTap: () async {

                                  launchUrl(Uri.parse(productDataStructure.productLink()));

                                },
                                onHover: (hovering) {

                                  hovering ? animationController.forward() : animationController.reverse();

                                },
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      SizedBox(
                                          height: 119,
                                          width: 119,
                                          child: WidgetMask(
                                              blendMode: BlendMode.srcATop,
                                              childSaveLayer: true,
                                              mask: ClipRRect(
                                                  borderRadius: BorderRadius.circular(13),
                                                  child: Image.network(
                                                      productDataStructure.productImage(),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                              child: const Image(
                                                image: AssetImage("assets/squircle_shape.png"),
                                                fit: BoxFit.cover,
                                              )
                                          )
                                      ),

                                      Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.only(left: 13, right: 13),
                                              child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      productDataStructure.productName(),
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          color: ColorsResources.premiumDark,
                                                          fontSize: 15
                                                      )
                                                  )
                                              )
                                          )
                                      )

                                    ]
                                )
                            )
                        )
                    )
                )
            )
        )
      )
    );
  }

}