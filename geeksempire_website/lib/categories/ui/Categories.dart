import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sachiel_website/resources/colors_resources.dart';

class Categories extends StatefulWidget {

  int productId;

  Categories({Key? key, required this.productId}) : super(key: key);

  @override
  State<Categories> createState() => CategoriesState();
}
class CategoriesState extends State<Categories> with TickerProviderStateMixin {

  ScrollController scrollController = ScrollController();

  Widget listViewPlaceholder = ListView();

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    if (widget.productId == 0) {

      // Most Used Category

    } else {

      // Category for Id
      listViewPlaceholder = ListView(
          controller: scrollController,
          children: [
            Text(
                widget.productId.toString(),
                style: TextStyle(
                  color: ColorsResources.red
                )
            )
          ]
      );

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

}