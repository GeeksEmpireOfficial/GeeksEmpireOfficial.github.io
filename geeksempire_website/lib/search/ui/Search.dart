import 'dart:async';
import 'dart:convert';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sachiel_website/network/endpoints/Endpoints.dart';
import 'package:sachiel_website/resources/colors_resources.dart';

class Search extends StatefulWidget {

  String searchQuery;

  Search({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}
class SearchState extends State<Search> with TickerProviderStateMixin {

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

    BackButtonInterceptor.add(aInterceptor);

    if (widget.searchQuery.isNotEmpty) {

      listViewPlaceholder = ListView(
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

  void retrieveSearch(String searchQuery) {

    retrieveSearchStorefront(searchQuery);

    retrieveSearchMagazine(searchQuery);

  }

  Future retrieveSearchStorefront(String searchQuery) async {
    debugPrint(endpoints.productsSearch(searchQuery));

    final productResponse = await http.get(Uri.parse(endpoints.productsSearch(searchQuery)));

    final productJson = jsonDecode(productResponse.body);

  }

  Future retrieveSearchMagazine(String searchQuery) async {
    debugPrint(endpoints.postsSearch(searchQuery));

    final postResponse = await http.get(Uri.parse(endpoints.postsSearch(searchQuery)));

    final postJson = jsonDecode(postResponse.body);

  }
  
}