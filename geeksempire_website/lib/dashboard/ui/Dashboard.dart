import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geeksempire_website/dashboard/provider/ContentDataStructure.dart';
import 'package:geeksempire_website/dashboard/provider/ContentProvider.dart';
import 'package:geeksempire_website/dashboard/ui/sections/content/item_desktop.dart';
import 'package:geeksempire_website/dashboard/ui/sections/content/item_mobile.dart';
import 'package:geeksempire_website/dashboard/ui/sections/header.dart';
import 'package:geeksempire_website/dashboard/ui/sections/menus.dart';
import 'package:geeksempire_website/resources/colors_resources.dart';
import 'package:geeksempire_website/utils/modifications/numbers.dart';
import 'package:geeksempire_website/utils/ui/display.dart';
import 'package:geeksempire_website/utils/ui/nexted_page_controller.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => DashboardState();
}
class DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  PageController pageController = PageController();

  /*
   * Start - Menu
   */
  late AnimationController animationController;

  late Animation<Offset> offsetAnimation;
  late Animation<double> scaleAnimation;
  BorderRadius radiusAnimation = BorderRadius.circular(0);

  late Animation<Offset> offsetAnimationItems;
  double opacityAnimation = 0.37;

  bool menuOpen = false;
  /*
   * End - Menu
   */

  /*
   * Start - Content Provider
   */
  ContentProvider contentProvider = ContentProvider();

  List<ContentDataStructure> allContent = [];

  Widget contentPlaceholder = Container();
  Widget nextIconPlaceholder = Container();

  bool nextVisibility = true;
  int pageIndex = 0;
  /*
   * End - Content Provider
   */

  /* Start - Next Page */
  double nextPageIndicatorHeight = 73;

  double nextPageIconHeight = 51;
  double nextPageIconWidth = 51;
  /* End - Next Page */

  bool aInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    SystemNavigator.pop();

    return true;
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(aInterceptor);

    animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 777),
        reverseDuration: const Duration(milliseconds: 333),
        animationBehavior: AnimationBehavior.preserve);

    offsetAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.51, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));
    scaleAnimation = Tween<double>(begin: 1, end: 0.91)
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut
    ));

    offsetAnimationItems = Tween<Offset>(begin: const Offset(-0.19, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));

    initializeScales();

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
        backgroundColor: ColorsResources.black,
        body: Stack(
            children: [

              /* Start - Menu Items */
              menuItems(),
              /* End - Menu Items */

              /* Start - Contents Widgets */
              allContentsWidgets(),
              /* End - Contents Widgets */

            ]
        )
    );
  }

  Widget allContentsWidgets() {

    return SlideTransition(
        position: offsetAnimation,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: Stack(
                children: [

                  /* Start - Content */
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                      color: ColorsResources.premiumDark,
                      borderRadius: radiusAnimation,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0
                      )
                    ),
                    child: contentPlaceholder
                  ),
                  /* End - Content */

                  /* Start - Header */
                  Header(dashboardState: this),
                  /* End - Header */

                  /* Start - Next */
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: nextPageIndicatorHeight,
                        child: Visibility(
                            visible: nextVisibility,
                            child: Stack(
                                children: [

                                  const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Image(
                                        image: AssetImage("images/next_background.png"),
                                      )
                                  ),

                                  Center(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(99),
                                          child: InkWell(
                                            onTap: () {

                                              if ((pageIndex + 1) == allContent.length) {

                                                pageController.animateToPage(0, duration: const Duration(milliseconds: 777), curve: Curves.easeInOutCubic);

                                              } else {

                                                pageController.nextPage(duration: const Duration(milliseconds: 555), curve: Curves.decelerate);

                                              }

                                            },
                                            child: nextIconPlaceholder
                                          )
                                      )
                                  )

                                ]
                            )
                        )
                      )
                    )
                  )
                  /* End - Next */

                ]
            )
        )
    );
  }

  Widget menuItems() {

    return Container(
        width: calculatePercentage(53, displayLogicalWidth(context)),
        alignment: AlignmentDirectional.centerStart,
        color: Colors.black,
        child: SlideTransition(
            position: offsetAnimationItems,
            child: AnimatedOpacity(
                opacity: opacityAnimation,
                duration: Duration(milliseconds: menuOpen ? 753 : 137),
                child: const Menus()
            )
        )
    );
  }

  /* Start - Content Provider */
  void prepareContent() {

    List<Widget> allContentWidgets = [];

    allContent = contentProvider.process();

    for (var element in allContent) {

      if (GetPlatform.isDesktop) {

        allContentWidgets.add(ItemDesktop(contentDataStructure: element));

      } else {

        allContentWidgets.add(ItemMobile(contentDataStructure: element));

      }

    }

    nextApplicationIcon();

    setState(() {

      contentPlaceholder = PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          physics: const NextedPageController(),
          onPageChanged: (index) {

            pageIndex = index;

            nextApplicationIcon();

          },
          children: allContentWidgets
      );

    });

  }

  void nextApplicationIcon() {

    if ((pageIndex + 1) == allContent.length) {

      setState(() {

        nextIconPlaceholder = SizedBox(
          height: nextPageIconHeight,
          width: nextPageIconWidth,
          child: Image.network(
            allContent[0].applicationIconValue(),
            height: nextPageIconHeight,
            width: nextPageIconWidth,
          )
        );

        nextVisibility = true;

      });

    } else {

      setState(() {

        nextIconPlaceholder = SizedBox(
          height: nextPageIconHeight,
          width: nextPageIconWidth,
          child: Image.network(
            allContent[pageIndex + 1].applicationIconValue(),
            height: nextPageIconHeight,
            width: nextPageIconWidth,
          )
        );

        nextVisibility = true;

      });

    }

  }
  /* End - Content Provider */

  void initializeScales() {

    setState(() {

      if (GetPlatform.isDesktop) {

        /* Start - Next Page */
        nextPageIndicatorHeight = 73;

        nextPageIconHeight = 51;
        nextPageIconWidth = 51;
        /* End - Next Page */

      } else {

        /* Start - Next Page */
        nextPageIndicatorHeight = 37;

        nextPageIconHeight = 27;
        nextPageIconWidth = 27;
        /* End - Next Page */

      }

    });

    prepareContent();

  }

}