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

class MagazineCategories extends StatefulWidget {

  int postId;

  MagazineCategories({Key? key, required this.postId}) : super(key: key);

  @override
  State<MagazineCategories> createState() => MagazineCategoriesState();
}
class MagazineCategoriesState extends State<MagazineCategories> with TickerProviderStateMixin {

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
    debugPrint("Post Id: ${widget.postId}");

    BackButtonInterceptor.add(aInterceptor);

    if (widget.postId == 0) {

    } else {

      listViewPlaceholder = ListView(
          controller: scrollController,
          children: const []
      );

      retrieveProduct(widget.postId);

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

  Future retrieveProduct(int postId) async {
    debugPrint(endpoints.postsById(postId));

    final postResponse = await http.get(Uri.parse(endpoints.postsById(postId)));

    final postJson = jsonDecode(postResponse.body);

    prepareCategories(postJson['categories']);

  }

  Future prepareCategories(postCategories) async {

    var categoriesList = List.from(postCategories);

    for (var element in categoriesList) {

      int categoryId = element;

      // Exclusions: 6004 - 5120
      if (categoryId != 1480
        && categoryId != 1857) {

        final categoryResponse = await http.get(Uri.parse(endpoints.categoriesById(categoryId)));

        final categoryJson = jsonDecode(categoryResponse.body);

        final categoryName = categoryJson['name'];
        debugPrint(categoryName);

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