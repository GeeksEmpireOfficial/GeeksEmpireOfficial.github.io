import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sachiel_website/data/PostDataStructure.dart';
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:sachiel_website/private/Privates.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';
import 'package:sachiel_website/search/ui/preview/ImagePreview.dart';
import 'package:shaped_image/shaped_image.dart';
import 'package:smooth_scroll_multiplatform/smooth_scroll_multiplatform.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/ProductDataStructure.dart';

class Search extends StatefulWidget {

  String searchQuery;

  Search({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}
class SearchState extends State<Search> with TickerProviderStateMixin {

  Endpoints endpoints = Endpoints();

  Widget listViewStorefront = ListView();
  Widget loadingStorefront = Container(
      height: 59,
      alignment: Alignment.centerLeft,
      child: LoadingAnimationWidget.discreteCircle(
          color: ColorsResources.premiumDark,
          secondRingColor: ColorsResources.lightOrange,
          thirdRingColor: ColorsResources.cyan,
          size: 13
      )
  );

  Widget listViewMagazine = ListView();
  Widget loadingMagazine = Container(
      height: 59,
      alignment: Alignment.centerLeft,
      child: LoadingAnimationWidget.discreteCircle(
          color: ColorsResources.premiumDark,
          secondRingColor: ColorsResources.lightOrange,
          thirdRingColor: ColorsResources.cyan,
          size: 13
      )
  );

  ScrollController scrollController = ScrollController();

  List<Widget> categoriesWidgets = [];

  String searchQueryExcerpt = "";
  
  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    if (widget.searchQuery.isNotEmpty) {

      listViewStorefront = ListView(
          controller: scrollController,
          children: const []
      );

      listViewMagazine = ListView(
          controller: scrollController,
          children: const []
      );

      retrieveSearch(widget.searchQuery);

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
          alignment: Alignment.topLeft,
          child: ListView(
              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(
                          "${StringsResources.exploringTitle()} ${widget.searchQuery.toUpperCase()}",
                          maxLines: 1,
                          style: const TextStyle(
                            color: ColorsResources.premiumDark,
                            fontSize: 31,
                            letterSpacing: 1.37,
                            fontWeight: FontWeight.bold
                          )
                      ),

                      Text(
                        searchQueryExcerpt,
                        maxLines: 5,
                        style: const TextStyle(
                          color: ColorsResources.premiumDark,
                          fontSize: 13
                        )
                      )

                    ]
                  )
                ),

                const Divider(
                  height: 37,
                  color: ColorsResources.transparent,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                      Row(
                        children: [

                          Container(
                            height: 59,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              StringsResources.storefrontTitle(),
                              maxLines: 1,
                              style: const TextStyle(
                                  color: ColorsResources.premiumDark,
                                  fontSize: 31,
                                  letterSpacing: 7
                              ),
                            )
                          ),

                          const SizedBox(
                            width: 13,
                          ),

                          loadingStorefront

                        ]
                      ),

                      const Divider(
                        height: 7,
                        color: ColorsResources.transparent,
                      ),

                      SizedBox(
                        height: 313,
                        width: double.infinity,
                        child: listViewStorefront,
                      ),

                      const Divider(
                        height: 37,
                        color: ColorsResources.transparent,
                      ),

                      Row(
                          children: [

                            Container(
                                height: 59,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  StringsResources.magazineTitle(),
                                  maxLines: 1,
                                  style: const TextStyle(
                                      color: ColorsResources.premiumDark,
                                      fontSize: 31,
                                      letterSpacing: 7
                                  ),
                                )
                            ),

                            const SizedBox(
                              width: 13,
                            ),

                            loadingMagazine

                          ]
                      ),

                      const Divider(
                        height: 7,
                        color: ColorsResources.transparent,
                      ),

                      SizedBox(
                        height: 313,
                        width: double.infinity,
                        child: listViewMagazine,
                      ),

                    ]
                )

              ]
          )
        )
    );
  }

  void retrieveSearch(String searchQuery) {

    retrieveSearchStorefront(searchQuery);

    retrieveSearchMagazine(searchQuery);

  }

  /*
   * Start - Storefront Search
   */
  Future retrieveSearchStorefront(String searchQuery) async {
    debugPrint(endpoints.productsSearch(searchQuery));

    final productsResponse = await http.get(Uri.parse(endpoints.productsSearch(searchQuery)));

    final productsJson = List.from(jsonDecode(productsResponse.body));

    if (productsJson.isEmpty) {

    } else {

      prepareProducts(productsJson);

    }

    setState(() {

      loadingStorefront = completeSearchDesign();

    });

  }

  void prepareProducts(List<dynamic> productsJson) {

    List<Widget> productsList = [];

    for (var element in productsJson) {

      ProductDataStructure productDataStructure = ProductDataStructure(element);

      productsList.add(itemProductsResults(productDataStructure, AnimationController(vsync: this,
          duration: const Duration(milliseconds: 333),
          reverseDuration: const Duration(milliseconds: 111),
          animationBehavior: AnimationBehavior.preserve)));

    }

    setState(() {

      listViewStorefront = DynMouseScroll(
          durationMS: 555,
          scrollSpeed: 5.5,
          animationCurve: Curves.easeInOut,
          builder: (context, controller, physics) => ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const RangeMaintainingScrollPhysics(),
              children: productsList
          )
      );

      loadingStorefront = Container();

    });

  }

  Widget itemProductsResults(ProductDataStructure productDataStructure, AnimationController animationController) {

    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 19),
        child: ScaleTransition(
          scale: Tween<double>(begin: 1, end: 1.013)
              .animate(CurvedAnimation(
              parent: animationController,
              curve: Curves.easeOut
          )),
          child: InkWell(
              onTap: () async {

                launchUrl(Uri.parse(productDataStructure.productLink()), mode: LaunchMode.externalApplication);

              },
              onHover: (hovering) {

                hovering ? animationController.forward() : animationController.reverse();

              },
              child: SizedBox(
                  height: 312,
                  width: 312,
                  child: Stack(
                      children: [

                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 307,
                              width: 310,
                              child: ShapedImage(
                                imageTye: ImageType.NETWORK,
                                path: productDataStructure.productImage(),
                                shape: Shape.Squarcle,
                                height: 307,
                                width: 310,
                                boxFit: BoxFit.cover,
                              )
                            )
                        ),

                        Align(
                            alignment: Alignment.center,
                            child: ShapedImage(
                              imageTye: ImageType.ASSET,
                              path: "assets/squarcle_adjustment.png",
                              shape: Shape.Squarcle,
                              height: 312,
                              width: 312,
                              boxFit: BoxFit.fill,
                            )
                        ),

                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 31),
                              child: SizedBox(
                                  height: 133,
                                  width: 254,
                                  child: Text(
                                      productDataStructure.productName(),
                                      textAlign: TextAlign.justify,
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 15,
                                          letterSpacing:  1.37
                                      )
                                  )
                              ),
                            )
                        )

                      ]
                  )
              )
          ),
        )
    );
  }
  /*
   * End - Storefront Search
   */

  /*
   * Start - Magazine Search
   */
  Future retrieveSearchMagazine(String searchQuery) async {
    debugPrint(endpoints.postsSearch(searchQuery));

    final postResponse = await http.get(Uri.parse(endpoints.postsSearch(searchQuery)),
      headers: {
        "Authorization": Privates.authenticationAPI,
      });

    final postJson = List.from(jsonDecode(postResponse.body));

    if (postJson.isEmpty) {

    } else {

      preparePosts(postJson);

    }

    setState(() {

      loadingMagazine = completeSearchDesign();

    });

  }

  void preparePosts(List<dynamic> postsJson) async {

    List<Widget> postsList = [];

    for (var element in postsJson) {

      PostDataStructure postDataStructure = PostDataStructure(element);



      postsList.add(itemPostsResults(postDataStructure, AnimationController(vsync: this,
          duration: const Duration(milliseconds: 333),
          reverseDuration: const Duration(milliseconds: 111),
          animationBehavior: AnimationBehavior.preserve)));

    }

    setState(() {

      listViewMagazine = DynMouseScroll(
          durationMS: 555,
          scrollSpeed: 5.5,
          animationCurve: Curves.easeInOut,
          builder: (context, controller, physics) => ListView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const RangeMaintainingScrollPhysics(),
              children: postsList
          )
      );

    });

  }

  Widget itemPostsResults(PostDataStructure postDataStructure, AnimationController animationController) {

    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(right: 19),
        child: ScaleTransition(
          scale: Tween<double>(begin: 1, end: 1.013)
              .animate(CurvedAnimation(
              parent: animationController,
              curve: Curves.easeOut
          )),
          child: InkWell(
              onTap: () async {

                launchUrl(Uri.parse(postDataStructure.postLink()), mode: LaunchMode.externalApplication);

              },
              onHover: (hovering) {

                hovering ? animationController.forward() : animationController.reverse();

              },
              child: SizedBox(
                  height: 312,
                  width: 237,
                  child: Stack(
                      children: [

                        Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 310,
                              width: 235,
                              child: ImagePreview(postId: postDataStructure.postId())
                            )
                        ),

                        const Align(
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage("images/rectarcle_adjustment.png"),
                              height: 312,
                              width: 237,
                              fit: BoxFit.cover,
                            )
                        ),

                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 31),
                              child: SizedBox(
                                  height: 133,
                                  width: 179,
                                  child: Text(
                                      postDataStructure.postTitle(),
                                      textAlign: TextAlign.justify,
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: ColorsResources.premiumLight,
                                          fontSize: 15,
                                          letterSpacing:  1.37
                                      )
                                  )
                              ),
                            )
                        )

                      ]
                  )
              )
          ),
        )
    );
  }
  /*
   * End - Magazine Search
   */

  Widget completeSearchDesign() {

    return Align(
      alignment: Alignment.bottomCenter,
      child:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border(
            left: BorderSide(
              width: 5,
              color: ColorsResources.premiumDark.withOpacity(0.51)
            ),
            right: BorderSide(
                width: 5,
                color: ColorsResources.premiumDark.withOpacity(0.51)
            ),
            top: BorderSide(
                width: 2,
                color: ColorsResources.premiumDark.withOpacity(0.51)
            ),
            bottom: BorderSide(
                width: 2,
                color: ColorsResources.premiumDark.withOpacity(0.51)
            ),
          ),
          color: ColorsResources.transparent
        ),
        child: Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {

              launchUrl(Uri.parse("https://GeeksEmpire.co/?s=${widget.searchQuery}"), mode: LaunchMode.platformDefault);

            },
            child: Padding(
                padding: const EdgeInsets.only(left: 17, right: 17, top: 3.7, bottom: 3.7),
                child: Text(
                    StringsResources.allSearch(),
                    style: const TextStyle(
                        color: ColorsResources.premiumDark,
                        fontSize: 11,
                        letterSpacing: 1.73
                    )
                )
            )
          )
        )
      )
    );
  }

}