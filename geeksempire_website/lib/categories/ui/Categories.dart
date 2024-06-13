import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';

class Categories extends StatefulWidget {

  int productId;

  Categories({Key? key, required this.productId}) : super(key: key);

  @override
  State<Categories> createState() => CategoriesState();
}
class CategoriesState extends State<Categories> with TickerProviderStateMixin {

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
    debugPrint(productCategories.toString());

    for (var element in productCategories.sublist(0, 3)) {
      debugPrint(element);



    }

  }

}