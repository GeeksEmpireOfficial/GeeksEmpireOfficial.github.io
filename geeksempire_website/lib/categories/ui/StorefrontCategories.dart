import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:url_launcher/url_launcher.dart';

class StorefrontCategories extends StatefulWidget {

  int productId;

  StorefrontCategories({Key? key, required this.productId}) : super(key: key);

  @override
  State<StorefrontCategories> createState() => StorefrontCategoriesState();
}
class StorefrontCategoriesState extends State<StorefrontCategories> with TickerProviderStateMixin {

  Endpoints endpoints = Endpoints();

  Widget listViewPlaceholder = ListView();

  ScrollController scrollController = ScrollController();

  List<Widget> categoriesWidgets = [];
  
  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();
    debugPrint("Product Id: ${widget.productId}");

    BackButtonInterceptor.add(aInterceptor);

    if (widget.productId == 0) {

    } else {

      listViewPlaceholder = ListView(
          controller: scrollController,
          children: const []
      );

      retrieveProduct(widget.productId);

    }

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
            height: 51,
            alignment: Alignment.center,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(19),
                child: SizedBox(
                    height: 51,
                    width: double.maxFinite,
                    child: listViewPlaceholder
                )
            )
        )
    );
  }

  Future retrieveProduct(int productId) async {
    debugPrint(endpoints.productsById(productId));

    final productResponse = await http.get(Uri.parse(endpoints.productsById(productId)));

    final productJson = jsonDecode(productResponse.body);

    prepareCategories(productJson['categories']);

  }

  void prepareCategories(productCategories) {

    var categoriesList = List.from(productCategories);

    for (var element in categoriesList) {

      String categoryId = element['id'].toString();
      String categoryName = element['name'].toString();

      // Exclusions: 6004 - 5120
      if (categoryId != '6004'
        && categoryId != '15'
        && categoryId != '80'
        && categoryId != '5969'
        && categoryId != '546'
        && categoryId != '982'
        && categoryId != '5120') {
        debugPrint(element['name'].toString());

        categoriesWidgets.add(categoryItem(categoryName, AnimationController(vsync: this,
            duration: const Duration(milliseconds: 333),
            reverseDuration: const Duration(milliseconds: 111),
            animationBehavior: AnimationBehavior.preserve)));

      }

    }

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
              children: categoriesWidgets
          )
      );

    });
    
  }

  Widget categoryItem(String categoryName, AnimationController animationController) {

    return Align(
        alignment: Alignment.centerLeft,
        child: ScaleTransition(
            scale: Tween<double>(begin: 1, end: 1.013)
                .animate(CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOut
            )),
            child: Padding(
              padding: const EdgeInsets.only(right: 13),
              child: SizedBox(
                  height: 51,
                  width: 173,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(19)),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(width: 7, color: ColorsResources.white.withOpacity(0.51)),
                                right: BorderSide(width: 7, color: ColorsResources.white.withOpacity(0.51)),
                                top: BorderSide(width: 3, color: ColorsResources.white.withOpacity(0.51)),
                                bottom: BorderSide(width: 3, color: ColorsResources.white.withOpacity(0.51)),
                              ),
                              borderRadius: const BorderRadius.all(Radius.circular(17)),
                              gradient: LinearGradient(
                                  colors: [
                                    ColorsResources.premiumLight,
                                    ColorsResources.white.withOpacity(0.51),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.centerRight
                              )
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(17)),
                            child: Material(
                                shadowColor: Colors.transparent,
                                color: Colors.transparent,
                                child: InkWell(
                                    splashColor: ColorsResources.lightBlue,
                                    splashFactory: InkRipple.splashFactory,
                                    onTap: () async {

                                      launchUrl(Uri.parse(endpoints.searchUrl(categoryName)), mode: LaunchMode.externalApplication);

                                    },
                                    onLongPress: () async {

                                      launchUrl(Uri.parse(endpoints.searchUrl(categoryName)), mode: LaunchMode.externalApplication);

                                    },
                                    onHover: (hovering) {

                                      hovering ? animationController.forward() : animationController.reverse();

                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 13, right: 13),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                categoryName.replaceAll("Products", ""),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: ColorsResources.premiumDark.withOpacity(0.73),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                        )
                                    )
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