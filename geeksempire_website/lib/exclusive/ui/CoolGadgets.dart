import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/exclusive/data/ProductDataStructure.dart';
import 'package:sachiel_website/exclusive/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:shaped_image/shaped_image.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:url_launcher/url_launcher.dart';

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

  ScrollController scrollController = ScrollController();

  Widget listViewPlaceholder = ListView();

  late Animation<double> scaleAnimation;

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    listViewPlaceholder = ListView(
        controller: scrollController,
        children: const []
    );

    retrieveCoolGadgets();

  }

  @override
  void dispose() {
    super.dispose();

    BackButtonInterceptor.remove(aInterceptor);

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorsResources.premiumLight,
        body: Container(
            height: 137,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(19),
              child: SizedBox(
                  height: 137,
                  width: double.maxFinite,
                  child: listViewPlaceholder
              )
            )
        )
    );
  }

  Future retrieveCoolGadgets() async {

    final coolGadgetsResponse = await http.get(Uri.parse(endpoints.productsByTag(widget.coolGadgetTag, productsPerPage: "99")));

    final coolGadgetsJson = List.from(jsonDecode(coolGadgetsResponse.body));

    prepareCoolGadgets(coolGadgetsJson);

  }

  void prepareCoolGadgets(List<dynamic> coolGadgetsJson) {

    coolGadgetsJson.shuffle();

    List<Widget> coolGadgetsList = [];

    int listSize = 13;

    if (coolGadgetsJson.length < 13) {

      listSize = coolGadgetsJson.length;

    }

    for (var element in coolGadgetsJson.sublist(0, listSize)) {

      ProductDataStructure productDataStructure = ProductDataStructure(element);

      coolGadgetsList.add(itemCoolGadgets(productDataStructure, AnimationController(vsync: this,
          duration: const Duration(milliseconds: 333),
          reverseDuration: const Duration(milliseconds: 111),
          animationBehavior: AnimationBehavior.preserve)));

    }

    coolGadgetsList.shuffle();

    setState(() {

      listViewPlaceholder = DynMouseScroll(
        durationMS: 555,
        scrollSpeed: 5.5,
        animationCurve: Curves.easeInOut,
        builder: (context, controller, physics) => ListView(
            controller: scrollController,
            padding: const EdgeInsets.only(left: 37, right: 37),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const RangeMaintainingScrollPhysics(),
            children: coolGadgetsList
        )
      );

      // initializeAutoScroll();

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
                                          child: ShapedImage(
                                              imageTye: ImageType.NETWORK,
                                              path: productDataStructure.productImage(),
                                              shape: Shape.Squircle,
                                              width: 200,
                                              height: 200
                                          ),
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

  double scrollPosition = 0;

  void initializeAutoScroll({double startingPosition = 379}) {

    scrollController.animateTo(startingPosition, duration: const Duration(milliseconds: 5555), curve: Curves.easeInOut).then((_) {

      if (startingPosition <= scrollController.position.maxScrollExtent) {

        initializeAutoScroll(startingPosition: scrollController.position.pixels + 379);

      } else {

        Future.delayed(const Duration(milliseconds: 3333), () {

          reverseAutoScroll(scrollController.position.maxScrollExtent);

        });

      }

    });

  }

  void reverseAutoScroll(double startingPosition) {

    scrollController.animateTo(startingPosition - (379), duration: const Duration(milliseconds: 5555), curve: Curves.easeInOut).then((_) {

      if (startingPosition >= scrollController.position.minScrollExtent) {

        reverseAutoScroll(startingPosition - (379));

      } else {

        Future.delayed(const Duration(milliseconds: 3333), () {

          initializeAutoScroll(startingPosition: 0);

        });

      }

    });

  }

}