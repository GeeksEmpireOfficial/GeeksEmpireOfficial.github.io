import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeksempire_website/data/ProductDataStructure.dart';
import 'package:geeksempire_website/network/endpoints/Endpoints.dart';
import 'package:geeksempire_website/private/Privates.dart';
import 'package:geeksempire_website/resources/colors_resources.dart';
import 'package:http/http.dart' as http;
import 'package:shaped_image/shaped_image.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:url_launcher/url_launcher.dart';

// <object type="text/html" data="https://geeks-empire-website.web.app/#/CoolGadgets" style="width:100%; height:137px; border:none;"> <p></p> </object>
class CoolGadgets extends StatefulWidget {

  final String coolGadgetTag = "5408";

  const CoolGadgets({Key? key}) : super(key: key);

  @override
  State<CoolGadgets> createState() => _CoolGadgetsState();
}
class _CoolGadgetsState extends State<CoolGadgets> with TickerProviderStateMixin {

  Endpoints endpoints = Endpoints();

  Widget listViewPlaceholder = ListView();

  ScrollController scrollController = ScrollController();

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

    final coolGadgetsResponse = await http.get(Uri.parse(endpoints.productsByTag(widget.coolGadgetTag, productsPerPage: "99")),
      headers: {
        "Authorization": Privates.authenticationAPI
      });

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
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const RangeMaintainingScrollPhysics(),
            children: coolGadgetsList
        )
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
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(51), bottomLeft: Radius.circular(51), topRight: Radius.circular(19), bottomRight: Radius.circular(19)),
                        border: Border(
                          left: BorderSide(width: 7, color: Color.fromRGBO(205, 229, 251, 1)),
                          right: BorderSide(width: 7, color: Color.fromRGBO(205, 229, 251, 1)),
                          top: BorderSide(width: 3, color: Color.fromRGBO(205, 229, 251, 1)),
                          bottom: BorderSide(width: 3, color: Color.fromRGBO(205, 229, 251, 1)),
                        ),
                        color: Color.fromRGBO(226, 234, 247, 1)
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(37), bottomLeft: Radius.circular(37), topRight: Radius.circular(17), bottomRight: Radius.circular(17)),
                      child: Material(
                          shadowColor: Colors.transparent,
                          color: Colors.transparent,
                          child: InkWell(
                              splashColor: ColorsResources.lightBlue,
                              splashFactory: InkRipple.splashFactory,
                              onTap: () async {

                                launchUrl(Uri.parse(productDataStructure.productExternalLink()), mode: LaunchMode.externalApplication);

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
                                          shape: Shape.Squarcle,
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