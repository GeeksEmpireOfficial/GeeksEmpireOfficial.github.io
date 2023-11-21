import 'package:flutter/material.dart';
import 'package:sachiel_website/resources/colors_resources.dart';
import 'package:sachiel_website/resources/strings_resources.dart';
import 'package:sachiel_website/utils/modifications/numbers.dart';
import 'package:sachiel_website/utils/ui/display.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  late Animation<double> scaleAnimation;
  BorderRadius radiusAnimation = BorderRadius.circular(0);

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

    offsetAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.39, 0))
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
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(19, 119, 19, 73),
                          physics: const BouncingScrollPhysics(),
                          children: [



                          ],
                        )
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

                                  radiusAnimation = BorderRadius.circular(0);

                                });

                              } else {


                                menuOpen = true;

                                animationController.forward().whenComplete(() {

                                });

                                setState(() {

                                  opacityAnimation = 1;

                                  radiusAnimation = BorderRadius.circular(37);

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

                                launchUrlString('#', mode: LaunchMode.externalApplication);

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

                      const Divider(
                        height: 99,
                        color: Colors.transparent,
                      ),

                      SizedBox(
                          height: 51,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                      splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {

                                        launchUrlString(StringsResources.projectsLink(), mode: LaunchMode.externalApplication);

                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            const Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Image(
                                                  image: AssetImage("assets/projects_icon.png"),
                                                  color: ColorsResources.light,
                                                  height: 51,
                                                  width: 51,
                                                )
                                            ),

                                            const SizedBox(
                                              width: 19,
                                            ),

                                            Expanded(
                                                child: Text(
                                                  StringsResources.projects(),
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: ColorsResources.lightTransparent,
                                                      fontSize: 19
                                                  ),
                                                )
                                            )

                                          ]
                                      )
                                  )
                              )
                          )
                      ),

                      const Divider(
                        height: 19,
                        color: ColorsResources.premiumDarkTransparent,
                      ),

                      SizedBox(
                          height: 51,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                      splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {

                                        launchUrlString(StringsResources.termServiceLink(), mode: LaunchMode.externalApplication);

                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            const Padding(
                                                padding: EdgeInsets.fromLTRB(3, 11, 11, 11),
                                                child: Image(
                                                  image: AssetImage("assets/tos.png"),
                                                  color: ColorsResources.light,
                                                  height: 51,
                                                  width: 51,
                                                )
                                            ),

                                            const SizedBox(
                                              width: 7,
                                            ),

                                            Expanded(
                                                child: Text(
                                                  StringsResources.termService(),
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: ColorsResources.lightTransparent,
                                                      fontSize: 15
                                                  ),
                                                )
                                            )

                                          ]
                                      )
                                  )
                              )
                          )
                      ),

                      const Divider(
                        height: 7,
                        color: Colors.transparent,
                      ),

                      SizedBox(
                          height: 51,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Material(
                                  shadowColor: Colors.transparent,
                                  color: Colors.transparent,
                                  child: InkWell(
                                      splashColor: ColorsResources.lightestYellow.withOpacity(0.31),
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {

                                        launchUrlString(StringsResources.privacyPolicyLink(), mode: LaunchMode.externalApplication);

                                      },
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [

                                            const Padding(
                                                padding: EdgeInsets.fromLTRB(3, 11, 11, 11),
                                                child: Image(
                                                  image: AssetImage("assets/privacy.png"),
                                                  color: ColorsResources.light,
                                                  height: 51,
                                                  width: 51,
                                                )
                                            ),

                                            const SizedBox(
                                              width: 7,
                                            ),

                                            Expanded(
                                                child: Text(
                                                  StringsResources.privacyPolicy(),
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                      color: ColorsResources.lightTransparent,
                                                      fontSize: 15
                                                  ),
                                                )
                                            )

                                          ]
                                      )
                                  )
                              )
                          )
                      ),

                      const Divider(
                        height: 73,
                        color: Colors.transparent,
                      ),

                      SizedBox(
                          height: 51,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                InkWell(
                                    onTap: () {

                                      launchUrlString(StringsResources.threadsLink(), mode: LaunchMode.externalApplication);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/threads_icon.png"),
                                      height: 51,
                                      width: 51,
                                    )
                                ),

                                Container(
                                  width: 13,
                                ),

                                InkWell(
                                    onTap: () {

                                      launchUrlString(StringsResources.twitterLink(), mode: LaunchMode.externalApplication);

                                    },
                                    child: const Image(
                                      image: AssetImage("assets/twitter_icon.png"),
                                      height: 51,
                                      width: 51,
                                    )
                                )

                              ]
                          )
                      ),

                    ]
                )
            )
        )
    );
  }

}