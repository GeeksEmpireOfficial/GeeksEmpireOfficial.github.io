import 'package:flutter/material.dart';
import 'package:sachiel_website/dashboard/sections/content/content.dart';
import 'package:sachiel_website/dashboard/sections/content/provider/content_data_structure.dart';
import 'package:sachiel_website/dashboard/sections/content/provider/content_provider.dart';
import 'package:sachiel_website/dashboard/sections/header.dart';
import 'package:sachiel_website/dashboard/sections/menus.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';
import 'package:sachiel_website/utils/modifications/numbers.dart';
import 'package:sachiel_website/utils/ui/display.dart';

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

  @override
  void initState() {
    super.initState();

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

    prepareContent();

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.geeksEmpire(),
            color: ColorsResources.black,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.black),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
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
            )
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
                        height: 73,
                        child: InkWell(
                          onTap: () {

                            if ((pageIndex + 1) == allContent.length) {

                              pageController.jumpToPage(0);

                            } else {

                              pageController.nextPage(duration: const Duration(milliseconds: 555), curve: Curves.decelerate);

                            }

                          },
                          child: Visibility(
                            visible: nextVisibility,
                            child: Stack(
                                children: [

                                  const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Image(
                                      image: AssetImage("assets/next_background.png"),
                                    )
                                  ),

                                  Center(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(99),
                                          child: nextIconPlaceholder
                                      )
                                  )

                                ]
                            )
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

      allContentWidgets.add(Item(contentDataStructure: element));

    }

    nextApplicationIcon();

    setState(() {

      contentPlaceholder = PageView(
          controller: pageController,
          scrollDirection: Axis.vertical,
          physics: const PageScrollPhysics(),
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

        nextIconPlaceholder = Image.network(
          allContent[0].applicationIcon,
          height: 51,
          width: 51,
        );

        nextVisibility = true;

      });

    } else {

      setState(() {

        nextIconPlaceholder = Image.network(
          allContent[pageIndex + 1].applicationIcon,
          height: 51,
          width: 51,
        );

        nextVisibility = true;

      });

    }

  }
  /* End - Content Provider */

}