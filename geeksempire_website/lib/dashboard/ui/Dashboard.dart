import 'package:flutter/material.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';
import 'package:sachiel_website/utils/modifications/numbers.dart';
import 'package:sachiel_website/utils/ui/display.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {

  /*
   * Start - Menu
   */
  late AnimationController animationController;

  late Animation<Offset> offsetAnimation;
  late Animation<double> doubleAnimation;

  late Animation<Offset> offsetAnimationItems;
  double opacityAnimation = 0.37;

  bool menuOpen = false;
  /*
   * End - Menu
   */

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 777),
        reverseDuration: const Duration(milliseconds: 333),
        animationBehavior: AnimationBehavior.preserve);

    offsetAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.49, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));
    doubleAnimation = Tween<double>(begin: 1, end: 0.91)
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut
    ));

    offsetAnimationItems = Tween<Offset>(begin: const Offset(-0.19, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn
    ));

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: StringsResources.geeksEmpire(),
            color: ColorsResources.premiumDark,
            theme: ThemeData(
              fontFamily: 'Ubuntu',
              colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorsResources.premiumDark),
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: ZoomPageTransitionsBuilder(),
                TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              }),
            ),
            home: Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: ColorsResources.premiumDark,
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
            scale: doubleAnimation,
            child: Stack(
                children: [

                  /* Start - Content */
                  Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(19))
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(19, 119, 19, 73),
                        physics: const BouncingScrollPhysics(),
                        children: [



                        ],
                      )
                  ),
                  /* End - Content */

                  /* Start - Menu */
                  Positioned(
                    left: 37,
                    top: 37,
                    child: SizedBox(
                        height: 59,
                        width: 59,
                        child: InkWell(
                            onTap: () {

                              if (menuOpen) {

                                menuOpen = false;

                                animationController.reverse().whenComplete(() {

                                });

                                setState(() {

                                  opacityAnimation = 0.37;

                                });

                              } else {


                                menuOpen = true;

                                animationController.forward().whenComplete(() {

                                });

                                setState(() {

                                  opacityAnimation = 1;

                                });

                              }

                            },
                            child: const Image(
                              image: AssetImage("assets/menu.png"),
                            )
                        )
                    ),
                  )
                  /* End - Menu */

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
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(19, 37, 0, 37),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: [

                      SizedBox(
                          height: 73,
                          child: InkWell(
                              onTap: () {

                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    const Image(
                                      image: AssetImage("assets/logo.png"),
                                      height: 73,
                                      width: 73,
                                    ),

                                    const SizedBox(
                                      width: 19,
                                    ),

                                    Expanded(
                                        child: Text(
                                          StringsResources.geeksEmpire(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: ColorsResources.light,
                                              fontSize: 23
                                          ),
                                        )
                                    )

                                  ]
                              )
                          )
                      ),

                    ]
                )
            )
        )
    );
  }

}